//
//  DetailVCDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit

class DetailVCDataSource: NSObject {
    
    fileprivate weak var viewController: DetailViewController!
    fileprivate weak var galleryCollection: UICollectionView!
    
//  - Init
    init(_ viewController: DetailViewController!, galleryCollection: UICollectionView!) {
        self.viewController = viewController
        self.galleryCollection = galleryCollection
        super.init()
        configure()
    }
}

// MARK: - Configure
extension DetailVCDataSource {
    private func configure(){
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        registerCell()
    }
    
    private func registerCell(){
        let galleryNib = UINib(nibName: GalleryCollectionViewCell.className, bundle: nil)
        galleryCollection.register(galleryNib, forCellWithReuseIdentifier: "galleryCell")
    }
}

// MARK: - CollectionView
extension DetailVCDataSource: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController.detailedInfo?.gallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryCollectionViewCell
        let gallery = viewController.detailedInfo?.gallery?[indexPath.item]
        cell.set(with: gallery!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galleryBrowserVC = UIStoryboard(name: GalleryBrowserViewController.className, bundle: nil).instantiateViewController(withIdentifier: "galleryBrowser") as! GalleryBrowserViewController
        galleryBrowserVC.gallery = viewController.detailedInfo?.gallery ?? []
        galleryBrowserVC.selectedImageIndex = indexPath.item
        galleryBrowserVC.modalPresentationStyle = .overFullScreen
        viewController.present(galleryBrowserVC, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 16
    }
}
