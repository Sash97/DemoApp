//
//  ViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 09.05.23.
//

import UIKit

protocol Sheetable: AnyObject {
    func presentActionSheet(with firstTitle: String,
                            and secondTitle: String,
                            firstAction: ((UIAlertAction) -> Void)?,
                            secondAction: ((UIAlertAction) -> Void)?,
                            thirdAction: ((UIAlertAction) -> Void)?,
                            fourthAction: ((UIAlertAction) -> Void)?)
}

extension Sheetable where Self: UIViewController {
    func presentActionSheet(with firstTitle: String,
                            and secondTitle: String,
                            firstAction: ((UIAlertAction) -> Void)?,
                            secondAction: ((UIAlertAction) -> Void)?,
                            thirdAction: ((UIAlertAction) -> Void)?,
                            fourthAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: firstTitle, style: .default, handler: firstAction))
        alert.addAction(UIAlertAction(title: secondTitle, style: .default, handler: secondAction))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Forget Password", style: .default, handler: thirdAction))
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: fourthAction))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let url = URL(string: "https://www.google.com")!
//        UIApplication.shared.open(url)

        textField.resignFirstResponder()

        if textField == emailTextField {
            print("DEBUG: --- uraa emaili  textfielnd a ---")
        } else if textField == passwordTextField {
            print("DEBUG: --- uraa passowrd i  textfielnd a ---")
        }

        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .red
        print("DEBUG: --- \(#function) ---")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("DEBUG: --- \(#function) ---")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .yellow
        print("DEBUG: --- \(#function) ---")
    }
}

extension LoginViewController: FooterViewDelegate {
    func startButtonDidTapped() {
        navigateToForgot()
    }
}

class LoginViewController: UIViewController, Sheetable {
    
    // MARK: - Outlets
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var backEmailView: UIView!
    @IBOutlet weak var backPasswordView: UIView!
    
    @IBOutlet weak var backLoginView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    
    private let validator = ValidatorService.shared
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("DEBUG: --- \(#function) ---")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Methods
    
    func configureUI() {
        title = "Login Screen"
        passwordTextField.delegate = self
        emailTextField.delegate    = self
        configureFooterView()
        configureCorners(on: topView)
        configureCorners(on: backEmailView)
        configureCorners(on: backPasswordView)
        backLoginView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 24)
        configureParams()
    }
    
    func configureCorners(on view: UIView) {
        view.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    func configureParams() {
        configureTextField(emailTextField, with: "Email", color: .white)
        configureTextField(passwordTextField, with: "Password", color: .white)
    }
    
    func configureTextField(_ textField: UITextField, with placeholder: String, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                     attributes: attributes)
    }
    
    func configureFooterView() {
        footerView.addDropShadow()
        
        guard let customView = FooterView.nib() else { return }
        customView.delegate = self
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)
        customView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        customView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func navigateToForgot() {
        showScreen(with: .forgetPassword)
    }
    
    // MARK: - Actions

    @IBAction func loginWithButtonAction(_ sender: AppButton) {
       presentActionSheet(with: "About Us",
                          and: "Login with Google") { action in
           self.showScreen(with: .aboutUs)
       } secondAction: { action in
           print("DEBUG: --- Second Action ---")
       } thirdAction: { action in
           self.navigateToForgot()
       } fourthAction: { action in
           self.showScreen(with: .tabBar)
       }
    }
}
