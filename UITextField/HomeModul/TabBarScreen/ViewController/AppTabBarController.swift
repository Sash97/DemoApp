//
//  AppTabBarController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 06.07.23.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        configureTabBarItems()
        configureBottomView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 13)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Methods
    
    private func configureControllers() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        delegate = self
        let homeVC        = getViewControllerFromStoryboard(storyboardType: .main, screenType: .home)
        homeVC.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), tag: 0)
        homeVC.tabBarItem = UITabBarItem(title: "HOME",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        let homeNavigationController = ABNavigationController(rootViewController: homeVC)
        
        let profileVC   = getViewControllerFromStoryboard(storyboardType: .main, screenType: .profile)
        profileVC.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.crop.circle"), tag: 1)
       
        let favouriteVC = getViewControllerFromStoryboard(storyboardType: .main, screenType: .favourite)
        favouriteVC.tabBarItem = UITabBarItem(title: "FAVOURITE", image: UIImage(systemName: "star.fill"), tag: 2)
        viewControllers = [profileVC, homeNavigationController, favouriteVC]
    }
    
    private func configureTabBarItems() {
        tabBar.tintColor = .purple
        tabBar.unselectedItemTintColor = UIColor.purple.withAlphaComponent(0.3)
        tabBar.backgroundColor = .white
        
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
    }

    
    private func configureBottomView() {
        view.addSubview(self.bottomView)
        bottomView.anchor(top: nil,
                          leading: self.view.leadingAnchor,
                          bottom: self.tabBar.topAnchor,//self.view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: self.view.trailingAnchor,
                          padding: .zero,//.init(top: 0, left: 0, bottom: 45, right: 0),
                          size: .init(width: 0, height: 20))
    }
}

extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController is HomeViewController {
//            return false
//        }
        return true
    }
}
