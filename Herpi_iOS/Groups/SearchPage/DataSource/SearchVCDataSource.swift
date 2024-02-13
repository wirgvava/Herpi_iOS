//
//  SearchVCDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 11.02.24.
//

import UIKit

class SearchVCDataSource: NSObject {
    
    fileprivate weak var viewController: SearchViewController!
    fileprivate weak var tableView: UITableView!
    
//  MARK: - Init
    init(viewController: SearchViewController!, tableView: UITableView!) {
        self.viewController = viewController
        self.tableView = tableView
        super.init()
        configure()
    }
}

// MARK: - Configure
extension SearchVCDataSource {
    private func configure(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TableView
extension SearchVCDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewController.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        let model = viewController.results?[indexPath.row]
        cell.set(with: model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewController.results?[indexPath.row]
        let vc = UIStoryboard(name: DetailViewController.className, bundle: nil).instantiateViewController(withIdentifier: "detailPage") as! DetailViewController
        vc.getDetailedInfo(for: (model?.id) ?? 0)
        vc.getCoverageInfo(for: (model?.id) ?? 0)
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
