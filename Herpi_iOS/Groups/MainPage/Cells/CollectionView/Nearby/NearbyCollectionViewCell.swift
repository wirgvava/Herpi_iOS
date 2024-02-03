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
        // Initialization code
    }

}
