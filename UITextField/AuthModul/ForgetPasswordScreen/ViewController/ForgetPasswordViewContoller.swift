//
//  ForgetPasswordViewContoller.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 23.05.23.
//

import UIKit

extension ForgetPasswordViewContoller: FooterViewDelegate {
    func startButtonDidTapped() {
        navigationController?.popViewController(animated: true)
    }
}

class ForgetPasswordViewContoller: UIViewController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBackItem()
        configureFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    deinit {
        print("DEBUG: --- \(#function) ---")
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        navigationItem.title = "Forgot Password"
        navigationItem.hidesBackButton = true
    }
    
    private func configureBackItem() {
        let backImage = UIImage(named: "icBackButton")?
            .scaled(toSize: .init(width: 33, height: 33))?
            .withRenderingMode(.alwaysOriginal)
        
        let customButton = UIBarButtonItem(image: backImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(customButtonTapped))
        navigationItem.leftBarButtonItem = customButton
    }
    
    private func configureFooterView() {
        guard let customView = FooterView.nib() else { return }
        customView.delegate = self
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)
        customView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        customView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func customButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func goToSignUpButtonAction(_ sender: AppButton) {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") else { return }
        navigationController?.pushViewController(signUpVC, animated: false)
    }
}
