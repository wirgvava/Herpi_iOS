//
//  GalleryBrowserDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 27.04.24.
//

import UIKit

class GalleryBrowserDataSource: NSObject {
    
    fileprivate weak var viewController: GalleryBrowserViewController!
    fileprivate weak var collectionView: UICollectionView!
    
//  - Init
    init(viewController: GalleryBrowserViewController!, collectionView: UICollectionView!) {
        self.viewController = viewController
        self.collectionView = collectionView
        super.init()
        configure()
    }
}

// MARK: - Configure
extension GalleryBrowserDataSource {
    private func configure(){
        registerCell()
        setCollectionViewHeight()
    }
    
    private func registerCell(){
        collectionView.dataSource = self
        collectionView.delegate = self
        let photoBrowserNib = UINib(nibName: PhotoBrowserCollectionViewCell.className, bundle: nil)
        collectionView.register(photoBrowserNib, forCellWithReuseIdentifier: "photoBrowserCell")
    }
    
    private func setCollectionViewHeight(){
        if let photoBrowserLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            photoBrowserLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

// MARK: - CollectionView
extension GalleryBrowserDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController.gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoBrowserCell", for: indexPath) as! PhotoBrowserCollectionViewCell
        let image = viewController.gallery[indexPath.item]
        cell.set(with: image)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryBrowserDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        let name = viewController.gallery[index].author?.firstName ?? ""
        let lastname = viewController.gallery[index].author?.lastName ?? ""
        viewController.author.text = "© " + name + " " + lastname
        viewController.imageCounter.text = "\(index + 1) / \(viewController.gallery.count)"
    }
}
