//
//  ReptiliesHeaderTableViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 08.02.24.
//

import UIKit

class ReptiliesHeaderTableViewCell: UITableViewCell {
    
//  MARK: - IBOutlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descr: UILabel!
  
    func set(data: [CategoryModel], indexPath: IndexPath?){
        var model: CategoryModel?
        
        if let indexPath = indexPath {
            model = data[indexPath.row]
        } else {
            model = data.first
        }
        
        title.text = model?.titleTurned
        descr.text = "list.description".localized
    }
}
