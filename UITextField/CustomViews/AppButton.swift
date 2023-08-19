//
//  AppButton.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 09.05.23.
//

import UIKit

class AppButton: UIButton {
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        configureUI()
    }
    
    // MARK: - Methods
    
    func configureUI() {
        backgroundColor = UIColor(hex: "6761BD")
        layer.cornerRadius = 8
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
}
