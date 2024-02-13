//
//  GalleryCollectionViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryPicture: UIImageView!
    @IBOutlet weak var author: UILabel!

    func set(with gallery: Gallery){
        let name = gallery.author?.firstName ?? ""
        let lastname = gallery.author?.lastName ?? ""
        author.text = "© " + name + " " + lastname
        galleryPicture.kf.setImage(with: URL(string: gallery.url ?? ""))
    }
}
