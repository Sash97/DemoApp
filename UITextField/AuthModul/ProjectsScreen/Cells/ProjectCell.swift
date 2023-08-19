//
//  ProjectCell.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 24.06.23.
//

import UIKit

class ProjectCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var bookNowButton: UIButton!
    
    // MARK: - Properties
    
    var onBookNowTap: ((UIImage?) -> ())?
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius(12)
        footerView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        bookNowButton.layer.cornerRadius = 8
    }
    
    // MARK: - Propeties
    
    static let identifier = "ProjectCell"

    // MARK: - Methods
    
    func setImage(with imageName: String) {
        projectImageView.image = UIImage(named: imageName)
    }
    
    // MARK: - Actions
    
    @IBAction func bookNowButtonAction(_ sender: UIButton) {
        onBookNowTap?(projectImageView.image)
    }
}
