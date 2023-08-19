//
//  ValidatorService.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 16.05.23.
//

import Foundation

final class ValidatorService {
    
    // MARK: - Properties
    
    static let shared = ValidatorService()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Methods
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkPassword(_ password: String) -> Bool {
        password.count >= 8
    }
}

