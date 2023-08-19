//
//  HomeViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 06.07.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let newtworkManager = NetworkManager()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        
        // https://jsonplaceholder.typicode.com/todos
        
        newtworkManager.getRequest(urlString: "https://jsonplaceholder.typicode.com/todos") { (result: Result<[TaskModel], Error>) in
            switch result {
            case .success(let responseObject):
                // Handle the received response object
                print("Response object received: \(responseObject)")
            case .failure(let error):
                // Handle the error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func showAboutUsButtonAction(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let presentVC = mainStoryBoard.instantiateViewController(identifier: ScreenType.aboutUs.identifier) as! AboutUsViewController
        tabBarController?.navigationController?.pushViewController(presentVC, animated: true)
    }
}
