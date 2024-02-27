//
//  TopViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 16.02.24.
//

import UIKit

class TopViewController: UIViewController {
    
    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    //  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.animateCoordinator(coordinator: coordinator)
    }
    
    deinit {
        unsubscribe()
    }
}

// MARK: - Configure
extension TopViewController {
    private func configure(){
        subscribe()
        setSideMenuShadow()
        setSideMenu()
        setSideMenuAutoLayout()
        setSideMenuGestures()
        showViewController(viewController: UINavigationController.self,
                           storyboardName: MainViewController.className,
                           storyboardId: "MainNavID")   // Default Main View Controller
    }
    
    private func setSideMenuShadow(){
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
    }
    
    private func setSideMenu(){
        let storyboard = UIStoryboard(name: SideMenuViewController.className, bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "menu") as? SideMenuViewController
        self.sideMenuViewController.delegate = self
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
    }
    
    private func setSideMenuAutoLayout(){
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setSideMenuGestures(){
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func animateCoordinator(coordinator: UIViewControllerTransitionCoordinator){
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    @IBAction open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        } else {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            } else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
}

// MARK: - Show Main ViewController
extension TopViewController {
    func showViewController<T: UIViewController>(viewController: T.Type, storyboardName: String ,storyboardId: String) -> (){
        for subview in view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        vc.view.tag = 99
        view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
        addChild(vc)
        DispatchQueue.main.async {
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                vc.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                vc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        if !self.revealSideMenuOnTop {
            if isExpanded {
                vc.view.frame.origin.x = self.sideMenuRevealWidth
            }
            if self.sideMenuShadowView != nil {
                vc.view.addSubview(self.sideMenuShadowView)
            }
        }
        vc.didMove(toParent: self)
    }
}

// MARK: - Menu Navigations
extension TopViewController: MenuDelegate {
    func openMainPage() {
        self.showViewController(viewController: UINavigationController.self, storyboardName: MainViewController.className, storyboardId: "MainNavID")
        self.sideMenuViewController.currentPage = .main
        self.sideMenuState(expanded: false)
    }
    
    func openContactPage() {
        self.showViewController(viewController: UINavigationController.self, storyboardName: ContactViewController.className, storyboardId: "ContactNavID")
        self.sideMenuViewController.currentPage = .contact
        self.sideMenuState(expanded: false)
    }
    
    func openTeamPage() {
        self.showViewController(viewController: UINavigationController.self, storyboardName: TeamViewController.className, storyboardId: "TeamNavID")
        self.sideMenuViewController.currentPage = .team
        self.sideMenuState(expanded: false)
    }
    
    func openFaqPage() {
        self.showViewController(viewController: UINavigationController.self, storyboardName: FAQViewController.className, storyboardId: "FAQNavID")
        self.sideMenuViewController.currentPage = .faq
        self.sideMenuState(expanded: false)
    }
    
    func didChangedLanguage() {
        if self.sideMenuViewController.languageSwitcher.selectedSegmentIndex == 0 {
            UserDefaultsManager.shared.save(value: .ka, forKey: .language)
            AppAnalytics.logEvents(with: .set_language, paramName: .language_code, paramData: "ka")
        } else {
            UserDefaultsManager.shared.save(value: .en, forKey: .language)
            AppAnalytics.logEvents(with: .set_language, paramName: .language_code, paramData: "en")
        }
        let center = NotificationCenter.default
        let languageSwitched = Notifications.languageSwitched.notificationName
        center.post(name: languageSwitched, object: nil)
    }
}

// MARK: - Gesutes
extension TopViewController: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        guard gestureEnabled == true else { return }
        switch sender.state {
        case .began:
            handlePanBegan(sender: sender)
        case .changed:
            handlePanChanged(sender: sender)
        case .ended:
            handlePanEnded(sender: sender)
        default:
            break
        }
    }
    
    private func handlePanBegan(sender: UIPanGestureRecognizer){
        let velocity: CGFloat = sender.velocity(in: self.view).x
        if sender.state == .began {
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            } else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
        }
    }
    
    private func handlePanChanged(sender: UIPanGestureRecognizer){
        let position: CGFloat = sender.translation(in: self.view).x
        if sender.state == .changed {
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                } else {
                    if let recogView = sender.view?.subviews[1] {
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        }
    }
    
    private func handlePanEnded(sender: UIPanGestureRecognizer){
        if sender.state == .ended {
            self.draggingIsEnabled = false
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            } else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        }
    }
}

// MARK: - Notifications
extension TopViewController {
    func unsubscribe(){
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    func subscribe(){
        let center = NotificationCenter.default
        let openFaq = Notifications.openFaqLink.notificationName
        center.addObserver(self, selector: #selector(openFaqDeepLink(_:)), name: openFaq, object: nil)
    }
    
    @objc func openFaqDeepLink(_ sender: Notification){
        openFaqPage()
    }
}
