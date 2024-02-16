//
//  TeamViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit
import SkeletonView

class TeamViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Managers
    private var serverManager = ApiManager()
    private var dataSource: TeamVCDataSource?
    
    // Data
    var team: [TeamData] = []

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
//  MARK: - IBActions
    @IBAction func didTapMenuButton(){
        print("menu tapped")
    }
    
    @IBAction func didTapChatButton(){
        openChat()
    }
}

// MARK: - Configure
extension TeamViewController {
    private func configure(){
        getTeam()
        setDataSource()
    }
    
    private func setDataSource(){
        dataSource = TeamVCDataSource(viewController: self, tableView: tableView)
    }
}

// MARK: - Handle Responses
extension TeamViewController {
    func getTeam(){
        serverManager.getTeam { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                model.forEach { model in
                    self.team.append(TeamData(opened: false, teamElement: model))
                }
                self.tableView.reloadData()
            }
        }
    }
}
