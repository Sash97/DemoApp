//
//  AboutUsCell.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 13.06.23.
//

import UIKit

class AboutUsCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCornerRadius(8)
        backView.addDropShadow(radius: 6, offset: .init(width: 0, height: 4))
        personImageView.applyCornerRadius(personImageView.frame.height / 2)
        personImageView.layer.borderColor = UIColor.orange.cgColor
        personImageView.layer.borderWidth = 2
    }
}
