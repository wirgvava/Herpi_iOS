//
//  CachedAsyncImage.swift
//  HerpiUI
//

import SwiftUI
import Kingfisher

/// A SwiftUI view that displays an image from URL with offline caching support using Kingfisher
public struct CachedAsyncImage<Placeholder: View>: View {
    let urlString: String?
    let placeholder: () -> Placeholder
    var renderingMode: Image.TemplateRenderingMode = .original

    public init(
        url urlString: String?,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        renderingMode: Image.TemplateRenderingMode = .original
    ) {
        self.urlString = urlString
        self.placeholder = placeholder
        self.renderingMode = renderingMode
    }

    public var body: some View {
        KFImage(URL(string: urlString ?? ""))
            .placeholder { placeholder() }
            .resizable()
            .renderingMode(renderingMode)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly(false)
            .fade(duration: 0.25)
            .resizable()
    }
}

// MARK: - Convenience initializers
extension CachedAsyncImage where Placeholder == ProgressView<EmptyView, EmptyView> {
    public init(url urlString: String?) {
        self.init(url: urlString) {
            ProgressView()
        }
    }
}

#Preview {
    VStack {
        CachedAsyncImage(url: "https://api.herpi.ge/uploads/2141.jpg") {
            Color.gray.opacity(0.3)
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
