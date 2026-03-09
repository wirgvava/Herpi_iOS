//
//  ImageCacheConfiguration.swift
//  HerpiUI
//

import Foundation
import Kingfisher

/// Configures Kingfisher image cache settings
public enum ImageCacheConfiguration {

    /// Configure default cache settings for the app
    /// Call this once at app launch
    public static func configure(
        memorySizeMB: Int = 100,
        diskSizeMB: Int = 500,
        diskExpiration: StorageExpiration = .never
    ) {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = memorySizeMB * 1024 * 1024
        cache.diskStorage.config.sizeLimit = UInt(diskSizeMB * 1024 * 1024)
        cache.diskStorage.config.expiration = diskExpiration
    }

    /// Prefetch multiple images for offline access
    /// - Parameter urls: Array of image URL strings
    /// - Returns: Number of successfully cached images
    public static func prefetchImages(urls: [String]) async -> Int {
        let cache = ImageCache.default
        let validURLs = urls.compactMap { URL(string: $0) }
        let urlsToFetch = validURLs.filter { !cache.isCached(forKey: $0.cacheKey) }

        guard !urlsToFetch.isEmpty else {
            return validURLs.count
        }

        return await withCheckedContinuation { continuation in
            let alreadyCached = validURLs.count - urlsToFetch.count
            var hasResumed = false
            let lock = NSLock()

            let prefetcher = ImagePrefetcher(
                urls: urlsToFetch,
                options: [.backgroundDecode],
                progressBlock: nil,
                completionHandler: { skipped, failed, completed in
                    lock.lock()
                    defer { lock.unlock() }
                    
                    guard !hasResumed else { return }
                    hasResumed = true
                    
                    let total = alreadyCached + completed.count + skipped.count
                    print("[ImageCache] Prefetched: \(completed.count) new, \(skipped.count) skipped, \(failed.count) failed")
                    continuation.resume(returning: total)
                }
            )
            prefetcher.start()
        }
    }

    /// Clear all cached images
    public static func clearAll() {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
        print("[ImageCache] Cleared all cached images")
    }

    /// Get current disk cache size in bytes
    public static func diskCacheSize() async -> UInt {
        await withCheckedContinuation { continuation in
            ImageCache.default.calculateDiskStorageSize { result in
                continuation.resume(returning: (try? result.get()) ?? 0)
            }
        }
    }
}
