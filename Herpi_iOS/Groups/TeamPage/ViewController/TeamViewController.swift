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

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit {
        unsubscribe()
    }
    
//  MARK: - IBActions
    @IBAction func didTapMenuButton(){
        openSideMenu(on: self)
    }
    
    @IBAction func didTapChatButton(){
        openChat()
    }
}

// MARK: - Configure
extension TeamViewController {
    private func configure(){
        setDataSource()
        subscribe()
        self.navigationController?.navigationBar.isHidden = true
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
                DataManager.shared.team.removeAll()
                model.forEach { model in
                    DataManager.shared.team.append(TeamData(opened: false, teamElement: model))
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Notifications
extension TeamViewController {
    func unsubscribe(){
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    func subscribe(){
        let center = NotificationCenter.default
        let languageSwitched = Notifications.languageSwitched.notificationName
        center.addObserver(self, selector: #selector(languageSwitched(_:)), name: languageSwitched, object: nil)
    }
    
    @objc func languageSwitched(_ sender: Notification){
        getTeam()
    }
}
