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
    
    var reptile: [ReptileModel] = []
    var nearbyReptiles: [NearbyReptileModel] = []
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
    }
    
    func updateData(){
        fillReptilesData()
        contentSize()
        viewController.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
        self.tableView.reloadData()
    }
    
    private func fillReptilesData(){
        self.reptile = viewController.allTypeReptile!
        contentSize()
    }
    
    func contentSize(){
        let reptiliesCount = self.reptile.count.toCGFloat()
        let tableViewContentSize = (200 * reptiliesCount) + 80
        let totalHeight = viewController.topCategoriesHeight.constant + tableViewContentSize
        viewController.contentViewHeight.constant = totalHeight
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:     return 60
        case 1:     return 200
        default:    return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        default:    fatalError("Unexpected section")
        }
    }
    
    private func reptileHeaderCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier.tableViewHeader, for: indexPath) as! ReptiliesHeaderTableViewCell
        cell.set(data: viewController.categories, indexPath: self.selectedCategoryIndex)
        return cell
    }
    
    private func reptileCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier.tableView, for: indexPath) as! ReptiliesTableViewCell
        let data = self.reptile[indexPath.row]
        cell.set(with: data)
        return cell
    }
}

// MARK: - CollectioView
extension MainVCDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            return viewController.categories.count
        case nearbyCollectionView:
            return self.nearbyReptiles.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:
            return categoriesCell(indexPath: indexPath)
        case nearbyCollectionView:
            return nearbyCell(indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func categoriesCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: identifier.categoriesCollectionView, for: indexPath) as! CategoriesCollectionViewCell
        let data = viewController.categories[indexPath.item]
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
            print("cell tapped!")
        default:
            break
        }
    }
    
    private func didSelectCategoryAt(indexPath: IndexPath){
        filterArrays(with: indexPath)
        updateNearbyCollectionViewLayout()
        updatePageControllerLayout()
        postNotificationAboutChanges()
        UserDefaultsManager.shared.save(value: false, data: .firstLoginSelected)
    }
    
    private func filterArrays(with indexPath: IndexPath){
        let data = viewController.categories[indexPath.item]
        self.selectedCategoryIndex = indexPath
        
        if indexPath.item == 0 {
            self.reptile = viewController.allTypeReptile!
            self.nearbyReptiles = viewController.nearbyReptiles
        } else {
            self.reptile = (viewController.allTypeReptile?.filter({$0.type == data.id!}))!
            self.nearbyReptiles = (viewController.nearbyReptiles.filter({$0.type == data.id}))
        }
    }
    
    private func updateNearbyCollectionViewLayout(){
        if self.nearbyReptiles.count == 0 {
            nearbyCollectionView.isHidden = true
            viewController.emptyNearbyList.isHidden = false
        } else {
            nearbyCollectionView.isHidden = false
            viewController.emptyNearbyList.isHidden = true
        }

        if self.nearbyReptiles.count == 0 || self.nearbyReptiles.count == 1 || self.nearbyReptiles.count == 2 {
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


extension MainVCDataSource: SkeletonCollectionViewDataSource, SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView {
        case categoriesCollectionView:
            return identifier.categoriesCollectionView
        case nearbyCollectionView:
            return identifier.nearbyCollectionView
        default:
            return identifier.tableView
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return identifier.tableView
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UITableView.automaticNumberOfSkeletonRows
    }
}
