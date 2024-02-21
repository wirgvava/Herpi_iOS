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
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var expandIcon: UIImageView!
    
    var email = ""
    
    @IBAction func didTapOnMail(){
        if let url = URL(string: "mailto:\(email)") {
            AppAnalytics.logEvents(with: .click_team_email, paramName: .member, paramData: email)
            UIApplication.shared.open(url)
        }
    }
    
//  MARK: - Configure
    func set(with model: TeamData){
        let data = model.teamElement
        self.email = data.email ?? ""
        avatar.kf.setImage(with: URL(string: data.avatar ?? ""))
        let name = data.firstName ?? ""
        let lastname = data.lastName ?? ""
        fullName.text = name + " " + lastname
        emailBtn.setAttrString(string: model.teamElement.email ?? "", fontSize: 13)
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
