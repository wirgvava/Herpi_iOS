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
    @IBOutlet weak var searchBarLbl: UILabel!
    @IBOutlet weak var nearYouLbl: UILabel!
    @IBOutlet weak var nearYouDescription: UILabel!
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
        openSideMenu(on: self)
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
        getTeamData()
        getFaq()
    }
    
    private func setDataSource(){
        dataSource = MainVCDataSource(viewController: self, tableView: tableView, categoriesCollectionView: categoriesCollectionView, nearbyCollectionView: nearbyCollectionView, pageController: pageController)
    }
    
    private func setLayout(){
        layout = MainVCLayout(viewController: self, tableView: tableView)
    }
    
    func sendEvent(model: NearbyReptilesModel){
        if model.count == 0 {
            AppAnalytics.logEvents(with: .nearby_species_not_found, paramName: .reason, paramData: "no species found in the area")
        }
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
                self.sendEvent(model: model)
            }
        }
    }
    
    func getCategories(){
        serviceManager.getCategories { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                DataManager.shared.categories = model
                self.categoriesCollectionView.reloadData()
                self.categoriesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            }
        }
    }
    
    func getReptiles(){
        serviceManager.getReptilesList { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                DataManager.shared.reptiles = model
                self.setDataSource()
                self.tableView.reloadData()
            }
        }
    }
    
    // fetch in background for cache this data
    func getTeamData(){
        serviceManager.getTeam { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                DataManager.shared.team.removeAll()
                model.forEach { model in
                    DataManager.shared.team.append(TeamData(opened: false, teamElement: model))
                }
            }
        }
    }
    
    func getFaq(){
        serviceManager.getFAQ { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                DataManager.shared.faq.removeAll()
                model.forEach { model in
                    DataManager.shared.faq.append(FAQData(opened: false, faqElement: model))
                }
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
        let languageSwitched = Notifications.languageSwitched.notificationName
        center.addObserver(self, selector: #selector(updateConstraints(_:)), name: updateHeightConstraint, object: nil)
        center.addObserver(self, selector: #selector(languageSwitched(_:)), name: languageSwitched, object: nil)
    }
    
    @objc func updateConstraints(_ sender: Notification){
        UIView.animate(withDuration: 0.25) {
            self.dataSource.setContent()
            self.nearbyCollectionView.reloadData()
            self.tableView.reloadData()
            self.scrollView.reloadInputViews()
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func languageSwitched(_ sender: Notification){
        getCategories()
        getNearbyReptiles(lat: lat, lng: lng)
        getReptiles()
        getTeamData()
        getFaq()
        layout.configure()
    }
}
