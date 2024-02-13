//
//  SearchVCLayout.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit

class SearchVCLayout: NSObject {
    
    fileprivate weak var viewController: SearchViewController!
    fileprivate weak var tableView: UITableView!
    fileprivate weak var searchTextField: UITextField!
    
    var panGesture = UIPanGestureRecognizer()
    
//  MARK: - Init
    init(_ viewController: SearchViewController!, tableView: UITableView!, searchTextField: UITextField!) {
        self.viewController = viewController
        self.tableView = tableView
        self.searchTextField = searchTextField
        super.init()
        configure()
    }
}

// MARK: - Configure
extension SearchVCLayout {
    private func configure(){
        setupGestures()
        searchTextField.delegate = self
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            searchTextField.resignFirstResponder()
        case .ended:
            tableView.removeGestureRecognizer(panGesture)
            
        default:
            break
        }
    }
}

// MARK: - Search TextField
extension SearchVCLayout: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewController.getSearchResult(with: textField.text ?? "")
        tableView.addGestureRecognizer(panGesture)
    }
}

//MARK: - Gesture to dismiss SearchBar
extension SearchVCLayout: UIGestureRecognizerDelegate {
    func setupGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSearchBar))
        tapGesture.delegate = self
        viewController.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissSearchBar(){
        searchTextField.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.tableView
    }
}
