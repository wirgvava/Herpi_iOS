//
//  GalleryBrowserViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 27.04.24.
//

import UIKit

class GalleryBrowserViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var imageCounter: UILabel!
    @IBOutlet weak var photoBrowser: UICollectionView!
    @IBOutlet weak var author: UILabel!
    
//  - Managers
    private var dataSource: GalleryBrowserDataSource!
    
//  - Data
    var gallery = [Gallery]()
    var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

//  MARK: - IBActions
    @IBAction func didTapOnBackButton(){
        self.dismiss(animated: false)
    }
}

//MARK: - Configure
extension GalleryBrowserViewController {
    private func configure(){
        setDataSource()
        configureLabels()
        configureImage()
    }
    
    private func setDataSource(){
        dataSource = GalleryBrowserDataSource(viewController: self, collectionView: photoBrowser)
    }
    
    private func configureLabels(){
        imageCounter.font = UIFont.herpi(type: .regular, size: 14)
        author.font = UIFont.herpi(type: .regular, size: 14)
    }
    
    private func configureImage(){
        let image = gallery[selectedImageIndex]
        let name = image.author?.firstName ?? ""
        let lastname = image.author?.lastName ?? ""
        author.text = "© " + name + " " + lastname
        imageCounter.text = "\(selectedImageIndex + 1) / \(gallery.count)"
        photoBrowser.reloadData()
        photoBrowser.layoutIfNeeded()
        photoBrowser.scrollToItem(at: IndexPath(item: selectedImageIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}
