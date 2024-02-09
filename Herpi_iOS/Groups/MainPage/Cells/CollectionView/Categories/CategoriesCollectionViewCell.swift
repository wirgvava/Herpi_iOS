//
//  CategoriesCollectionViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit
import Kingfisher

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
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.widthAnchor.constraint(
            equalToConstant: (UIScreen.main.bounds.size.width - 108) / 3).isActive = true
    }
    
//  MARK: - Methods
    func set(with data: CategoryModel){
        title.text = data.titleTurned
        icon.kf.setImage(with: URL(string: data.iconURL!)) { result in
            switch result {
            case .success:
                self.icon.image = self.icon.image?.withRenderingMode(.alwaysTemplate)
                self.icon.tintColor = self.isSelected ? Colors.white : Colors.defaultDark
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateCellSelection() {
        bgView.backgroundColor = isSelected ? Colors.selectedTint : Colors.white
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = isSelected ? Colors.white : Colors.defaultDark
    }
}
