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
    
    // Data
    var faq: [FAQData] = []

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
//  MARK: - IBActions
    @IBAction func didTapMenu(){
        print("menu tapped")
    }
    
    @IBAction func didTapChat(){
        openChat()
    }
}

// MARK: - Configure
extension FAQViewController {
    private func configure(){
        getFAQ()
        setDataSource()
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
                model.forEach { model in
                    self.faq.append(FAQData(opened: false, faqElement: model))
                }
                self.tableView.reloadData()
            }
        }
    }
}

