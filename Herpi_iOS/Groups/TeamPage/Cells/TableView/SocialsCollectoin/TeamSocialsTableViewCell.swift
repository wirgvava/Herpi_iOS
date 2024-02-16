//
//  TeamSocialsTableViewCell.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

class TeamSocialsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var socialNetworks = [SocialNetwork]()

    override func awakeFromNib() {
        super.awakeFromNib()
        let socialsNib = UINib(nibName: SocialsCollectionViewCell.className, bundle: nil)
        collectionView.register(socialsNib, forCellWithReuseIdentifier: "socialsCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CollectionView
extension TeamSocialsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(socialNetworks.count)
        return socialNetworks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialsCell", for: indexPath) as! SocialsCollectionViewCell
        let data = socialNetworks[indexPath.item]
        cell.icon.image = cell.icon.image?.withRenderingMode(.alwaysTemplate)
        cell.icon.tintColor = Colors.headerTitle
        cell.icon.kf.setImage(with: URL(string: data.networkLogoUrl ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = socialNetworks[indexPath.item]
        if let url = URL(string: data.url!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
