//
//  MainVCDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit
import SkeletonView

class MainVCDataSource: NSObject {
    
    fileprivate weak var viewController: MainViewController!
    fileprivate weak var tableView: UITableView!
    fileprivate weak var categoriesCollectionView: UICollectionView!
    fileprivate weak var nearbyCollectionView: UICollectionView!
    fileprivate weak var pageController: UIPageControl!
    
//  - Filtered Data
    var reptile: [ReptileModel] = []
    var nearbyReptiles: [NearbyReptileModel] = []
    
//  - Selected category
    var selectedCategoryIndex: IndexPath?
    
//  MARK: - Init
    init(viewController: MainViewController!, tableView: UITableView!, categoriesCollectionView: UICollectionView!, nearbyCollectionView: UICollectionView!, pageController: UIPageControl!) {
        self.viewController = viewController
        self.tableView = tableView
        self.categoriesCollectionView = categoriesCollectionView
        self.nearbyCollectionView = nearbyCollectionView
        self.pageController = pageController
        super.init()
        configure()
    }
}

// MARK: - Configure
extension MainVCDataSource {
    private func configure(){
        tableView.dataSource = self
        tableView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        nearbyCollectionView.dataSource = self
        nearbyCollectionView.delegate = self
        registerCells()
        setContent()
    }
    
    func setContent(){
        DispatchQueue.main.async {
            self.reptile = DataManager.shared.reptiles
            self.setCollectionViewHeights()
            self.setTopCategoryViewHeight()
            self.contentSize()
    //        self.viewController.view.hideSkeleton()
            self.tableView.reloadData()
        }
    }
    
    func setTopCategoryViewHeight(){
        var totalHeightOfViews = 0.toCGFloat()
        viewController.topCategoryViews.forEach { view in
            totalHeightOfViews += view.frame.height
        }
        
        let totalTopCategoryHeight = totalHeightOfViews + 167
        viewController.topCategoriesHeight.constant = totalTopCategoryHeight
        viewController.nearbyCollectionView.reloadData()
    }
    
    private func setCollectionViewHeights(){
        if let categoryCollectionViewLayout = viewController.categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            categoryCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        if let nearbyCollectionViewLayout = viewController.nearbyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            nearbyCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func contentSize(){
        let reptiliesCount = self.reptile.count.toCGFloat()
        let tableViewContentSize = (200 * reptiliesCount) + 112
        let totalHeight = viewController.topCategoriesHeight.constant + tableViewContentSize
        self.viewController.contentViewHeight.constant = totalHeight
    }

    private func registerCells(){
        tableView.register(UINib(nibName: ReptiliesHeaderTableViewCell.className, bundle: nil), forCellReuseIdentifier: identifier.tableViewHeader)
        
        tableView.register(UINib(nibName: ReptiliesTableViewCell.className, bundle: nil), forCellReuseIdentifier: identifier.tableView)
        
        let categoriesNib = UINib(nibName: CategoriesCollectionViewCell.className, bundle: nil)
        categoriesCollectionView.register(categoriesNib, forCellWithReuseIdentifier: identifier.categoriesCollectionView)
        
        let nearbyNib = UINib(nibName: NearbyCollectionViewCell.className, bundle: nil)
        nearbyCollectionView.register(nearbyNib, forCellWithReuseIdentifier: identifier.nearbyCollectionView)
    }
    
    enum identifier {
        static let tableView = "ReptiliesTableViewCell"
        static let tableViewHeader = "ReptiliesHeaderCell"
        static let categoriesCollectionView = "CategoriesCollectionViewCell"
        static let nearbyCollectionView = "NearbyCollectionViewCell"
    }
}

// MARK: - TableView
extension MainVCDataSource: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:     return 60
        case 1:     return 200
        default:    return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:     return 1
        case 1:     return self.reptile.count
        default:    return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:     return reptileHeaderCell(indexPath: indexPath)
        case 1:     return reptileCell(indexPath: indexPath)
        default:    return UITableViewCell()
        }
    }
    
    private func reptileHeaderCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier.tableViewHeader, for: indexPath) as! ReptiliesHeaderTableViewCell
        cell.set(data: DataManager.shared.categories, indexPath: self.selectedCategoryIndex)
        return cell
    }
    
    private func reptileCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier.tableView, for: indexPath) as! ReptiliesTableViewCell
        let data = self.reptile[indexPath.row]
        cell.set(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.reptile[indexPath.row]
        let vc = UIStoryboard(name: DetailViewController.className, bundle: nil).instantiateViewController(withIdentifier: "detailPage") as! DetailViewController
        guard let id = data.id else { return }
        vc.reptileId = id
        AppAnalytics.logEvents(with: .open_details, paramName: .specie_id, paramData: id)
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectioView
extension MainVCDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:  return DataManager.shared.categories.count
        case nearbyCollectionView:      return self.nearbyReptiles.count
        default:                        return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:  return categoriesCell(indexPath: indexPath)
        case nearbyCollectionView:      return nearbyCell(indexPath: indexPath)
        default:                        return UICollectionViewCell()
        }
    }
    
    private func categoriesCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: identifier.categoriesCollectionView, for: indexPath) as! CategoriesCollectionViewCell
        let data = DataManager.shared.categories[indexPath.item]
        if UserDefaultsManager.shared.getBool(data: .firstLoginSelected) == true {
            self.categoriesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        }
        cell.set(with: data)
        return cell
    }
    
    private func nearbyCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = nearbyCollectionView.dequeueReusableCell(withReuseIdentifier: identifier.nearbyCollectionView, for: indexPath) as! NearbyCollectionViewCell
        let data = self.nearbyReptiles[indexPath.item]
        cell.set(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoriesCollectionView:
            didSelectCategoryAt(indexPath: indexPath)
        case nearbyCollectionView:
            didSelectNearbyItemAt(indexPath: indexPath)
        default:
            break
        }
    }
    
    private func didSelectNearbyItemAt(indexPath: IndexPath){
        let data = self.nearbyReptiles[indexPath.item]
        let vc = UIStoryboard(name: DetailViewController.className, bundle: nil).instantiateViewController(withIdentifier: "detailPage") as! DetailViewController
        guard let id = data.id else { return }
        vc.reptileId = id
        AppAnalytics.logEvents(with: .open_nearby_specie_details, paramName: .specie_id, paramData: id)
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didSelectCategoryAt(indexPath: IndexPath){
        filterArrays(with: indexPath)
        updateNearbyCollectionViewLayout()
        updatePageControllerLayout()
        postNotificationAboutChanges()
        sendEvent(indexPath: indexPath)
        UserDefaultsManager.shared.save(value: false, forKey: .firstLoginSelected)
    }
    
    private func sendEvent(indexPath: IndexPath){
        let categories = DataManager.shared.categories[indexPath.item]
        guard let categoryId = categories.id else { return }
        AppAnalytics.logEvents(with: .select_category, paramName: .category_id, paramData: categoryId)
    }
    
    private func filterArrays(with indexPath: IndexPath){
        let storedReptiles = DataManager.shared.reptiles
        let storedNearby = DataManager.shared.nearbyReptiles
        let categories = DataManager.shared.categories[indexPath.item]
        self.selectedCategoryIndex = indexPath
        
        if indexPath.item == 0 {
            self.reptile = storedReptiles
            self.nearbyReptiles = storedNearby
        } else {
            self.reptile = (storedReptiles.filter({$0.type == categories.id!}))
            self.nearbyReptiles = (storedNearby.filter({$0.type == categories.id}))
        }
        tableView.reloadData()
        nearbyCollectionView.reloadData()
    }
    
    private func updateNearbyCollectionViewLayout(){
        if self.nearbyReptiles.count == 0 {
            nearbyCollectionView.isHidden = true
            viewController.emptyNearbyList.isHidden = false
            AppAnalytics.logEvents(with: .nearby_species_not_found, paramName: .reason, paramData: "no species found in the area")
        } else {
            nearbyCollectionView.isHidden = false
            viewController.emptyNearbyList.isHidden = true
        }

        if self.nearbyReptiles.count <= 2 {
            viewController.nearbyCollectionHeight.constant = 162.5
        } else {
            viewController.nearbyCollectionHeight.constant = 325
        }
    }
    
    private func updatePageControllerLayout(){
        viewController.pageController.numberOfPages = (self.nearbyReptiles.count / 2 == 0) ? (self.nearbyReptiles.count / 4) : (self.nearbyReptiles.count / 3)
    }
    
    private func postNotificationAboutChanges(){
        let center = NotificationCenter.default
        let updateConstraints = Notifications.updateHeightConstraints.notificationName
        center.post(name: updateConstraints, object: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainVCDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 24
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageController.currentPage = index
    }
}

// MARK: - Skeleton
extension MainVCDataSource: SkeletonCollectionViewDataSource, SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView {
        case categoriesCollectionView:      return identifier.categoriesCollectionView
        case nearbyCollectionView:          return identifier.nearbyCollectionView
        default:                            return identifier.tableView
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return identifier.tableView
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UITableView.automaticNumberOfSkeletonRows
    }
}
