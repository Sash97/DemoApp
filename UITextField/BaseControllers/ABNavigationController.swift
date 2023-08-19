//
//  ABNavigationController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 23.05.23.
//

import UIKit

enum NavigationBarStyle {
    case dark
    case light
    
    var color: UIColor {
        switch self {
        case .dark: return .black
        case .light: return .white
        }
    }
}

class ABNavigationController: UINavigationController {
    
    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    // MARK: - Methods

    func configureNavigationBar(with style: NavigationBarStyle = .light) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: style.color,
                                                .font: UIFont.boldSystemFont(ofSize: 22)]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                     .font: UIFont.boldSystemFont(ofSize: 30)]
        self.navigationBar.tintColor = style.color
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
