//
//  DetailViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var photo: UIImageView!
    // info Card
    @IBOutlet weak var infoCard: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scientificNameLbl: UILabel!
    @IBOutlet weak var familyLbl: UILabel!
    @IBOutlet weak var venomView: UIView!
    @IBOutlet weak var venomInfoLbl: UILabel!
    @IBOutlet weak var redFlagView: UIView!
    @IBOutlet weak var refFlagViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descAboutRedFlag: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var authorAvatar: UIImageView!
    
    @IBOutlet weak var descrTitle: UILabel!
    @IBOutlet weak var descrLbl: UILabel!

    @IBOutlet weak var galleryLbl: UILabel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var galleryCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reptileAreasLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var openMapBtn: UIButton!
    
//  - Managers
    private var serviceManager = ApiManager()
    private var layout: DetailVCLayout?
    private var dataSource: DetailVCDataSource?
    
//  - Data
    var detailedInfo: DetailedInfoResponseModel?
    var coverage: [CoverageModelElement] = []

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showAnimatedSkeleton()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removePanGesture(on: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addPanGesture(on: self)
    }
    
//  MARK: - IBActions
    @IBAction func didTapBackBtn(){
        PresenterManager.shared.pop(self)
    }
    
    @IBAction func didTapShareBtn(){
        layout?.shareAction()
    }
    
    @IBAction func didTapOpenMapBtn(){
        layout?.openMap()
    }
}

// MARK: - Configure
extension DetailViewController {
    private func configure(){
        setLayout()
        setDataSource()
    }
    
    private func setLayout(){
        layout = DetailVCLayout(viewController: self)
    }
    
    private func setDataSource(){
        dataSource = DetailVCDataSource(self, galleryCollection: galleryCollectionView)
    }
}

// MARK: - Handle Responses
extension DetailViewController {
    func getDetailedInfo(for reptileId: Int){
        serviceManager.getDetailedInfo(for: reptileId) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let response = response {
                self.detailedInfo = response
                self.layout?.configure()
                self.galleryCollectionView.reloadData()
                self.view.hideSkeleton()
            }
        }
    }
    
    func getCoverageInfo(for reptileId: Int){
        serviceManager.getCoverageInfo(for: reptileId) { [weak self] model, error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let model = model {
                self.coverage = model
            }
        }
    }
}
