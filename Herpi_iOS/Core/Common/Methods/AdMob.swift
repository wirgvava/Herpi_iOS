//
//  AdMob.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 22.02.24.
//

import UIKit
import GoogleMobileAds

func addBannerView(to view: UIView, rootVC: UIViewController, bannerView: GADBannerView) {
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    bannerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    bannerView.adUnitID = Bundle.main.infoDictionary?["GADBannerID"] as? String
    bannerView.rootViewController = rootVC
    bannerView.load(GADRequest())
}
