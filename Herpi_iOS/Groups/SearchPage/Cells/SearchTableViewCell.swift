//
//  SearchTableViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 11.02.24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
//  MARK: - IBOutlets
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scientificName: UILabel!
    @IBOutlet weak var venomTypeView: UIView!
    @IBOutlet weak var venomTypeLbl: UILabel!
    
//  MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//  MARK: - Methods
    func set(with model: SearchedData){
        nameLbl.text = model.name
        scientificName.text = model.scientificName
        photo.kf.setImage(with: URL(string: (model.image)!))
        
        if model.hasMildVenom == true {
            venomTypeView.backgroundColor = Colors.venomType(.midVenom)
            venomTypeLbl.text = "mid.venomous".localized
        } else if model.venomous == true {
            venomTypeView.backgroundColor = Colors.venomType(.venomous)
            venomTypeLbl.text = "venomous".localized
        } else {
            venomTypeView.backgroundColor = Colors.venomType(.noVenom)
            venomTypeLbl.text = "no.venomous".localized
        }
    }
}
