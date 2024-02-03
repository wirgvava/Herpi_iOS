//
//  MainViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit

class MainViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topCategoriesView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var nearbyCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    private var dataSource: MainVCDataSource!

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        let totalHeight = topCategoriesView.frame.height + (tableView.rowHeight * CGFloat(10) + 20)
     
        contentViewHeight.constant = totalHeight
    }
    
//  MARK: - IBActions
    @IBAction func didTapMenuButton(){
        print("Menu Button Tapped!")
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
        setDataSource()
    }
    
    private func setDataSource(){
        dataSource = MainVCDataSource(viewController: self,
                                      tableView: tableView,
                                      categoriesCollectionView: categoriesCollectionView,
                                      nearbyCollectionView: nearbyCollectionView, pageController: pageController)
    }
}

