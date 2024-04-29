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
    }
    
    func set(with data: ReptileModel){
        nameLabel.text = data.name
        familyLabel.text = data.family?.name
        picture.kf.setImage(with: URL(string: data.transparentThumbnail ?? ""))
        
        if data.hasMildVenom == true {
            infoIcon.tintColor = Colors.venomType(.midVenom)
            infoLabel.text = Localized.midVenom.localized
        } else if data.venomous == true {
            infoIcon.tintColor = Colors.venomType(.venomous)
            infoLabel.text = Localized.venomous.localized
        } else {
            infoIcon.tintColor = Colors.venomType(.noVenom)
            infoLabel.text = Localized.noVenom.localized
        }
        
        detailedButton.layer.cornerRadius = detailedButton.frame.height / 2
        detailedButton.setAttrString(string: Localized.readMore.localized, fontSize: 12)
    }
    
    private enum Localized {
        static let venomous = "venomous"
        static let midVenom = "mid.venomous"
        static let noVenom = "no.venomous"
        static let readMore = "list.detailed.button"
    }
}
