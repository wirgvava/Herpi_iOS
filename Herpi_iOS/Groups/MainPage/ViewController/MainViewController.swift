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
    
//  - Managers
    private var dataSource: MainVCDataSource!
    private var layout: MainVCLayout!
    private var serviceManager = MainVCServiceManager()
    
//  - Data
    var categories: [CategoryModel] = []
    var nearbyReptiles: [NearbyReptileModel] = []
    var allTypeReptile: [ReptileModel]? {
        didSet{
            dataSource.updateData()
        }
    }

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
        print("Chat Button Tapped!")
    }
    
    @IBAction func didTapOnSearch(){
        print("Search is Tapped!")
    }
}

// MARK: - Configure
extension MainViewController {
    private func configure(){
        getCategories()
        getReptilies()
        setDataSource()
        setLayout()
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
    func getCategories(){
        serviceManager.getCategories { categoryModel, error in
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = categoryModel {
                self.categories = model
                self.categoriesCollectionView.reloadData()
            }
        }
    }
    
    func getReptilies(){
        serviceManager.getReptiliesList() { model, error in
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                self.allTypeReptile = model
                self.tableView.reloadData()
            }
        }
    }
    
    func getNearbyReptiles(lat: Double, lng: Double){
        serviceManager.getNearbyReptileList(lat: lat, lng: lng) { model, error in
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                self.nearbyReptiles = model
                self.dataSource.nearbyReptiles = model
                self.pageController.numberOfPages = (model.count / 2 == 0) ? (model.count / 4) : (model.count / 3)
                self.nearbyCollectionView.reloadData()
            }
        }
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
            self.layout.setTopCategoryViewHeight()
            self.dataSource.contentSize()
            self.nearbyCollectionView.reloadData()
            self.tableView.reloadData()
            self.scrollView.reloadInputViews()
        }
    }
}
