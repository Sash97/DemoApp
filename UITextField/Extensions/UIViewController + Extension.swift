//
//  UIViewController + Extension.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 22.06.23.
//

import UIKit

enum ScreenType {
    
    // AUTH
    
    case registration
    case details(model: Person)
    case aboutUs
    case forgetPassword
    case projects
    case date
    
    // HOME
    case tabBar
    case home
    case favourite
    case profile
    
    var identifier: String {
        switch self {
        case .forgetPassword: return "ForgetPasswordViewContoller"
        case .aboutUs: return "AboutUsViewController"
        case .details: return "DetailsViewController"
        case .registration: return "RegisterViewController"
        case .projects: return "ProjectsViewController"
        case .date: return "DateViewController"
        case .tabBar: return "AppTabBarController"
            
        case .home: return "HomeViewController"
        case .favourite: return "FavouriteViewController"
        case .profile: return "ProfileViewController"
        }
    }
}

extension UIViewController {
   
    func showScreen(with screenType: ScreenType) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let presentVC = mainStoryBoard.instantiateViewController(identifier: screenType.identifier)
        presentVC.modalPresentationStyle = .fullScreen
        
        if let detailsVC = presentVC as? DetailsViewController {
            if case let .details(person) = screenType {
                detailsVC.person = person
            }
        }
        
        show(presentVC, sender: self)
    }
    
    func getViewControllerFromStoryboard(storyboardType: SroyboardType,
                                         screenType: ScreenType) -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: screenType.identifier)
        return vc
    }
}

enum SroyboardType: String {
    case main = "Main"
}
