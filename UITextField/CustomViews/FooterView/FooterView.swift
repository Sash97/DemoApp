//
//  FooterView.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 06.06.23.
//

import UIKit

extension NSObject {
    static var id: String {
        return String(describing: self)
    }
}

extension UIView {
    static var viewFromNib: UIView? {
        guard let view = UINib(nibName: Self.id, bundle: nil).instantiate(withOwner: Self.self, options: [:]).first as? Self else {
            return nil
        }
        return view
    }
}

protocol FooterViewDelegate: AnyObject {
    func startButtonDidTapped()
}

class FooterView: UIView {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Properties -
    
    weak var delegate: FooterViewDelegate?
    
    // MARK: - LifeCycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSubviews()
    }
    
    // MARK: - Methods -
    
    static func nib() -> FooterView? {
        guard let view = FooterView.viewFromNib as? FooterView else { return nil }
        view.configureSubviews()
        return view
    }
    
    // MARK: - Actions
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        delegate?.startButtonDidTapped()
    }
}

private extension FooterView {
    func configureSubviews() {
        startButton.applyCornerRadius(12)
        backgroundColor = .yellow
        applyCornerRadius(20)
    }
}


