//
//  SearchViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 11.02.24.
//

import UIKit

class SearchViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
//  - Managers
    private var dataSource: SearchVCDataSource?
    private var layout: SearchVCLayout?
    private var serverManager = ApiManager()
 
//  - Data
    var results: [SearchedData]? = []

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
//  MARK: - IBActions
    @IBAction func didTapBackButton(){
        PresenterManager.shared.pop(self)
    }
}

// MARK: - Configure
extension SearchViewController {
    private func configure(){
        setDataSource()
        setLayout()
    }
    
    private func setDataSource(){
        dataSource = SearchVCDataSource(viewController: self, tableView: tableView)
    }
    
    private func setLayout(){
        layout = SearchVCLayout(self, tableView: tableView, searchTextField: searchTextField)
    }
}

// MARK: - Handle Responses
extension SearchViewController {
    func getSearchResult(with query: String){
        serverManager.getSearchResult(with: query) {[weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let response = response {
                self.results = response.data
                self.tableView.reloadData()
            }
        }
    }
}