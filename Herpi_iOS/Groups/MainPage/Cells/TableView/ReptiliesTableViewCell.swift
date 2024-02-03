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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configure(){
        detailedButton.layer.cornerRadius = detailedButton.frame.height / 2
    }
}
