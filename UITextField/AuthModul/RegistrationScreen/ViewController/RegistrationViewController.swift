//
//  RegistrationViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 20.05.23.
//

import UIKit

class RegistrationViewController: UIViewController, Sheetable {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        configureRightItems()
    }
    
    // MARK: - Methods
    
    func configureTitleView() {
        let titleView = ABSecondaryTitleView(title: "Sign Up", subtitle: "Hello")
        navigationItem.titleView = titleView
    }
    
    func configureRightItems() {
        let trashImage = UIImage(systemName: "trash.fill")
        let cancelImage = UIImage(systemName: "xmark.circle.fill")
        
        let cancelButton = UIBarButtonItem(image: cancelImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        
        let trashButton = UIBarButtonItem(image: trashImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(trashButtonTapped))
        
        navigationItem.rightBarButtonItems = [cancelButton, trashButton]
    }
    
    // MARK: - Actions
    
    @objc func trashButtonTapped() {
        presentActionSheet(with: "Trash all files",
                           and: "Trash only unsaved files") { action in
            print("DEBUG: --- Trash all files ---")
        } secondAction: { action in
            print("DEBUG: --- Trash only unsaved files ---")
        } thirdAction: { action in
            print("DEBUG: --- Trash only unsaved files ---")
        } fourthAction: { action in
            
        }
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
//        navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
}

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}

class ABSecondaryTitleView: BaseView {
    
    // MARK: - Properties
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    convenience init(title: String,
                     subtitle: String,
                     textColor: UIColor = .white,
                     backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.titleLabel.textColor = textColor
        self.subtitleLabel.textColor = textColor
    }
    
    // MARK: - Methods
    
    func setNames(title: String, susbtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = susbtitle
    }
    
    override func setupView() {
        self.setLabel()
    }
    
    private func setLabel() {
        addSubview(titlesStackView)
        titlesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titlesStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

