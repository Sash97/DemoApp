//
//  UIImage + Extension.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 23.05.23.
//

import UIKit

extension UIImage {
    func scaled(toSize newSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        let scaledImage = renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return scaledImage
    }
}
