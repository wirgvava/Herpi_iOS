//
//  ReptiliesTableViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit

class ReptiliesTableViewCell: UITableViewCell {
    
//  MARK: - IBOutlets
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var detailedButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure(){
        detailedButton.layer.cornerRadius = detailedButton.frame.height / 2
    }
    
    func set(with data: ReptileModel){
        nameLabel.text = data.name
        familyLabel.text = data.family?.name
        picture.kf.setImage(with: URL(string: data.image!))
        
        if data.hasMildVenom == true {
            infoIcon.tintColor = Colors.venomType(.midVenom)
            infoLabel.text = "სუსტად შხამიანი"
        } else if data.venomous == true {
            infoIcon.tintColor = Colors.venomType(.venomous)
            infoLabel.text = "შხამიანი"
        } else {
            infoIcon.tintColor = Colors.venomType(.noVenom)
            infoLabel.text = "უშხამო"
        }
    }
}
