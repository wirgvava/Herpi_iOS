//
//  TeamVCDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

class TeamVCDataSource: NSObject {
    
    fileprivate weak var viewController: TeamViewController!
    fileprivate weak var tableView: UITableView!
        
//  MARK: - Init
    init(viewController: TeamViewController? = nil, tableView: UITableView) {
        self.viewController = viewController
        self.tableView = tableView
        super.init()
        configure()
    }
}

// MARK: - Configure
extension TeamVCDataSource {
    private func configure(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TableView
extension TeamVCDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.team.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.team[section].opened == true {
            return DataManager.shared.team.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
            let data = DataManager.shared.team[indexPath.section]
            cell.set(with: data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "socialsCell", for: indexPath) as! TeamSocialsTableViewCell
            let data = DataManager.shared.team[indexPath.section].teamElement
            cell.socialNetworks = data.socialNetworks!
            cell.memberEmail = data.email!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if DataManager.shared.team[indexPath.section].opened == true {
                DataManager.shared.team[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            } else {
                DataManager.shared.team[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            }
        }
    }
}
