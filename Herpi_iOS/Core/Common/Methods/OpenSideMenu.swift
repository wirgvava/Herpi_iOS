//
//  OpenSideMenu.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 16.02.24.
//

import UIKit

func openSideMenu(on vc: UIViewController){
    vc.revealViewController()?.revealSideMenu()
}

func removePanGesture(on vc: UIViewController){
    vc.revealViewController()?.gestureEnabled = false
}

func addPanGesture(on vc: UIViewController){
    vc.revealViewController()?.gestureEnabled = true
}
