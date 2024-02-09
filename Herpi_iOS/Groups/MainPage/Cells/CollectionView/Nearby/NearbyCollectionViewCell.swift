//
//  NearbyCollectionViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit

class NearbyCollectionViewCell: UICollectionViewCell {
    
//  MARK: - IBOutlets
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.widthAnchor.constraint(
            equalToConstant: (UIScreen.main.bounds.size.width - 84) / 2).isActive = true
        picture.heightAnchor.constraint(
            equalToConstant: (picture.frame.width / 17) * 9).isActive = true
    }
    
    func set(with data: NearbyReptileModel){
        nameLabel.text = data.name
        picture.kf.setImage(with: URL(string: data.image!))
        
        if data.hasMildVenom == true {
            infoView.backgroundColor = Colors.venomType(.midVenom)
            infoLabel.text = "სუსტად შხამიანი"
        } else if data.venomous == true {
            infoView.backgroundColor = Colors.venomType(.venomous)
            infoLabel.text = "შხამიანი"
        } else {
            infoView.backgroundColor = Colors.venomType(.noVenom)
            infoLabel.text = "უშხამო"
        }
    }
}
