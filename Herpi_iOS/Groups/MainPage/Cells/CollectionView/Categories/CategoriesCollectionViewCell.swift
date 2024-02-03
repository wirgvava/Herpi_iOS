//
//  CategoriesCollectionViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
//  MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override var isSelected: Bool {
        didSet {
            updateCellSelection()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//  MARK: - Methods
    private func updateCellSelection() {
        let greenColor = UIColor(red: 4/255, green: 84/255, blue: 70/255, alpha: 1)
        bgView.backgroundColor = isSelected ? greenColor : UIColor.white
    }
}
