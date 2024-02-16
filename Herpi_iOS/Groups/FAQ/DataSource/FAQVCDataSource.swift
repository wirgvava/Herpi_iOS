//
//  FAQVCDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

class FAQVCDataSource: NSObject {
    
    fileprivate weak var viewController: FAQViewController!
    fileprivate weak var tableView: UITableView!
    
//  MARK: - Init
    init(viewController: FAQViewController!, tableView: UITableView!) {
        self.viewController = viewController
        self.tableView = tableView
        super.init()
        configure()
    }
}

// MARK: - Configure
extension FAQVCDataSource {
    private func configure(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TableView
extension FAQVCDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewController.faq.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewController.faq[section].opened == true {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "faqHeaderCell", for: indexPath) as! FAQHeaderTableViewCell
            let model = viewController.faq[indexPath.section]
            cell.set(with: model)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "faqDescriptionCell", for: indexPath) as! FAQDescrtiptionTableViewCell
            let data = viewController.faq[indexPath.section].faqElement
            cell.descriptionLbl.text = data.answer
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if viewController.faq[indexPath.section].opened == true {
                viewController.faq[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            } else {
                viewController.faq[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            }
        }
    }
}
