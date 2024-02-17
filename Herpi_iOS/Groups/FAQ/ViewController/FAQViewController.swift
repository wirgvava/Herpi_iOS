//
//  FAQViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

class FAQViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Managers
    private var serverManager = ApiManager()
    private var dataSource: FAQVCDataSource?

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit {
        unsubscribe()
    }
    
//  MARK: - IBActions
    @IBAction func didTapMenu(){
        openSideMenu(on: self)
    }
    
    @IBAction func didTapChat(){
        openChat()
    }
}

// MARK: - Configure
extension FAQViewController {
    private func configure(){
        setDataSource()
        subscribe()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setDataSource(){
        dataSource = FAQVCDataSource(viewController: self, tableView: tableView)
    }
}

// MARK: - Handle Responses
extension FAQViewController {
    func getFAQ(){
        serverManager.getFAQ { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                DataManager.shared.faq.removeAll()
                model.forEach { model in
                    DataManager.shared.faq.append(FAQData(opened: false, faqElement: model))
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Notifications
extension FAQViewController {
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
        getFAQ()
    }
}

