//
//  MainVCDataSource.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit

class MainVCDataSource: NSObject {
    
    fileprivate weak var viewController: MainViewController!
    fileprivate weak var tableView: UITableView!
    fileprivate weak var categoriesCollectionView: UICollectionView!
    fileprivate weak var nearbyCollectionView: UICollectionView!
    fileprivate weak var pageController: UIPageControl!
    
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
    
    private func registerCells(){
        tableView.register(UINib(nibName: ReptiliesTableViewCell.className, bundle: nil), forCellReuseIdentifier: identifier.tableView)
        
        let categoriesNib = UINib(nibName: CategoriesCollectionViewCell.className, bundle: nil)
        categoriesCollectionView.register(categoriesNib, forCellWithReuseIdentifier: identifier.categoriesCollectionView)
        
        let nearbyNib = UINib(nibName: NearbyCollectionViewCell.className, bundle: nil)
        nearbyCollectionView.register(nearbyNib, forCellWithReuseIdentifier: identifier.nearbyCollectionView)
        
        categoriesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    enum identifier {
        static let tableView = "ReptiliesTableViewCell"
        static let categoriesCollectionView = "CategoriesCollectionViewCell"
        static let nearbyCollectionView = "NearbyCollectionViewCell"
    }
}

// MARK: - TableView
extension MainVCDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier.tableView, for: indexPath) as! ReptiliesTableViewCell
        cell.nameLabel.text = "ჩვეულებრივი ანკარა"
        return cell
    }
}

// MARK: - CollectioView
extension MainVCDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            return 5
        case nearbyCollectionView:
            return 10
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
        cell.title.text = "ყველა"
        return cell
    }
    
    private func nearbyCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = nearbyCollectionView.dequeueReusableCell(withReuseIdentifier: identifier.nearbyCollectionView, for: indexPath) as! NearbyCollectionViewCell
        cell.infoLabel.text = "უშხამო"
        cell.nameLabel.text = "ჩვეულებრივი ანკარა"
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoriesCollectionView:
            let width = (viewController.view.bounds.width - 108) / 3
            return CGSize(width: width, height: 130)
        case nearbyCollectionView:
            let width = (viewController.view.bounds.width - 84) / 2
            return CGSize(width: width, height: 144)
        default:
            return CGSize()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageController.currentPage = index
    }
}
