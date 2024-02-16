//
//  FAQHeaderTableViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

class FAQHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var expandIcon: UIImageView!
    @IBOutlet weak var topCornersView: UIView!
    @IBOutlet weak var bottomCornersView: UIView!

    func set(with model: FAQData){
        let data = model.faqElement
        title.text = data.question
        
        topCornersView.layer.masksToBounds = true
        bottomCornersView.layer.masksToBounds = true
        if model.opened == true {
            bottomCornersView.layer.cornerRadius = 0
            title.textColor = Colors.white
            expandIcon.tintColor = Colors.white
            topCornersView.backgroundColor = Colors.selectedTint
            bottomCornersView.backgroundColor = Colors.selectedTint
            expandIcon.image = UIImage(systemName: "chevron.up")
        } else {
            bottomCornersView.layer.cornerRadius = 16
            title.textColor = Colors.headerTitle
            expandIcon.tintColor = Colors.headerTitle
            topCornersView.backgroundColor = Colors.white
            bottomCornersView.backgroundColor = Colors.white
            expandIcon.image = UIImage(systemName: "chevron.down")
        }
    }
}
