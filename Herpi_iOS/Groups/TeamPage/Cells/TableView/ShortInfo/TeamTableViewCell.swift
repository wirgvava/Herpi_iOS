//
//  TeamTableViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
//  MARK: - IBOutlets
    @IBOutlet weak var topCorners: UIView!
    @IBOutlet weak var bottomCorners: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var expandIcon: UIImageView!
    
//  MARK: - Configure
    func set(with model: TeamData){
        let data = model.teamElement
        avatar.kf.setImage(with: URL(string: data.avatar ?? ""))
        let name = data.firstName ?? ""
        let lastname = data.lastName ?? ""
        fullName.text = name + " " + lastname
        email.text = data.email
        role.text = data.role
        
        topCorners.layer.masksToBounds = true
        bottomCorners.layer.masksToBounds = true
        topCorners.layer.cornerRadius = 16
        
        if model.opened == true {
            bottomCorners.layer.cornerRadius = 0
            expandIcon.image = UIImage(systemName: "chevron.up")
        } else {
            bottomCorners.layer.cornerRadius = 16
            expandIcon.image = UIImage(systemName: "chevron.down")
        }
    }
}
