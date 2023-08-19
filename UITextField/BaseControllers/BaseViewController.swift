//
//  BaseViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 11.05.23.
//

import UIKit

class BaseViewController: UIViewController {
    func roundCorners(customView: UIView, corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: customView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        customView.layer.mask = mask
    }
}
