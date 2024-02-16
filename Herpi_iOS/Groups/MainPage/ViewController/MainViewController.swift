//
//  MainViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit
import Loaf

class MainViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet var topCategoryViews: [UIView]!
    @IBOutlet weak var topCategoriesView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topCategoriesHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var nearbyCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var nearbyCollectionView: UICollectionView!
    @IBOutlet weak var emptyNearbyList: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var currentLocationLbl: UILabel!
    
    // Managers
    private var dataSource: MainVCDataSource!
    private var layout: MainVCLayout!
    private var serviceManager = ApiManager()
    
    // Default Location
    var lat = Constants.lat
    var lng = Constants.lng

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit{
        unsubscribe()
    }
    
//  MARK: - IBActions
    @IBAction func didTapMenuButton(){
        layout.openMenu()
    }
    
    @IBAction func didTapChatButton(){
        openChat()
    }
    
    @IBAction func didTapOnSearch(){
        PresenterManager.shared.navigate(from: self, to: .searchPage)
    }
    
    @IBAction func didTapChooseLocationManually(){
        layout.openLocationSheet()
    }
}

// MARK: - Configure
extension MainViewController {
    private func configure(){
        setLayout()
        setDataSource()
        subscribe()
    }
    
    private func setDataSource(){
        dataSource = MainVCDataSource(viewController: self, tableView: tableView, categoriesCollectionView: categoriesCollectionView, nearbyCollectionView: nearbyCollectionView, pageController: pageController)
    }
    
    private func setLayout(){
        layout = MainVCLayout(viewController: self, tableView: tableView)
    }
}

// MARK: - Handle Responses
extension MainViewController {
    func getNearbyReptiles(lat: Double, lng: Double){
        serviceManager.getNearbyReptileList(lat: lat, lng: lng) { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                DataManager.shared.nearbyReptiles = model
                self.dataSource.nearbyReptiles = model
                self.pageController.numberOfPages = (model.count / 2 == 0) ? (model.count / 4) : (model.count / 3)
                self.nearbyCollectionView.reloadData()
            }
        }
    }
}

// MARK: - Did Changed location
extension MainViewController: LocationDelegate {
    func didChangedLocationWith(lat: Double, lng: Double, name: String) {
        currentLocationLbl.text = name
        getNearbyReptiles(lat: lat, lng: lng)
    }
}

// MARK: - Notifications
extension MainViewController {
    func unsubscribe(){
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    func subscribe(){
        let center = NotificationCenter.default
        let updateHeightConstraint = Notifications.updateHeightConstraints.notificationName
        center.addObserver(self, selector: #selector(updateConstraints(_:)), name: updateHeightConstraint, object: nil)
    }
    
    @objc func updateConstraints(_ sender: Notification){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.layout.setTopCategoryViewHeight()
                self.dataSource.contentSize()
                self.nearbyCollectionView.reloadData()
                self.tableView.reloadData()
                self.scrollView.reloadInputViews()
                self.view.layoutIfNeeded()
            }
        }
    }
}
