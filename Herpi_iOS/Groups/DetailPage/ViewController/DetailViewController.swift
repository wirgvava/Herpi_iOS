//
//  DetailViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit
import MapKit
import SkeletonView
import GoogleMobileAds
import Reachability

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
    
    // ad banners
    @IBOutlet weak var adBanner_1: UIView!
    @IBOutlet weak var adBanner_2: UIView!
    @IBOutlet weak var adBanner_3: UIView!
    var bannerView_1: GADBannerView!
    var bannerView_2: GADBannerView!
    var bannerView_3: GADBannerView!
    
    // interstitial ad
    var interstitial: GADInterstitialAd?
    
//  - Managers
    private var serviceManager = ApiManager()
    private var layout: DetailVCLayout?
    private var dataSource: DetailVCDataSource?
    fileprivate let reachability = try! Reachability()
    
//  - Data
    var reptileId = 0
    var detailedInfo: DetailedInfoResponseModel?
    var coverage: [CoverageModelElement] = []

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.showAnimatedSkeleton()
        getDetailedInfo(for: reptileId)
        getCoverageInfo(for: reptileId)
        setLayout()
        setDataSource()
        setAdBanners()
        loadIntersisialAd()
    }
    
    private func setLayout(){
        layout = DetailVCLayout(viewController: self)
    }
    
    private func setDataSource(){
        dataSource = DetailVCDataSource(self, galleryCollection: galleryCollectionView)
    }
    
    private func setAdBanners(){
        if reachability.connection == .unavailable {
            adBanner_1.layer.isHidden = true
            adBanner_2.layer.isHidden = true
            adBanner_3.layer.isHidden = true
        } else {
            adBanner_1.layer.isHidden = false
            adBanner_2.layer.isHidden = false
            adBanner_3.layer.isHidden = false
            bannerView_1 = GADBannerView(adSize: GADAdSizeBanner)
            addBannerView(to: adBanner_1, rootVC: self, bannerView: bannerView_1)
            bannerView_2 = GADBannerView(adSize: GADAdSizeBanner)
            addBannerView(to: adBanner_2, rootVC: self, bannerView: bannerView_2)
            bannerView_3 = GADBannerView(adSize: GADAdSizeBanner)
            addBannerView(to: adBanner_3, rootVC: self, bannerView: bannerView_3)
        }
    }
    
    private func loadIntersisialAd(){
        let request = GADRequest()
        let adUnitID = Bundle.main.infoDictionary?["GADInterstitialID"] as? String ?? ""

        GADInterstitialAd.load(withAdUnitID: adUnitID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
            } else if let ad = ad {
                interstitial = ad
            }
        }
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
                self.view.hideSkeleton()
                self.detailedInfo = response
                self.layout?.configure()
                self.galleryCollectionView.reloadData()
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
