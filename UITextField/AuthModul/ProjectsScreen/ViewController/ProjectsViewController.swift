//
//  ProjectsViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 24.06.23.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectsCollectionView: UICollectionView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var footerBottomSheetView: UIView!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var projects = ["imgAladdin", "imgBeautyBest", "imgMermaid",
                    "imgSnowWhite", "imgBeautyBest", "imgMermaid", "imgSnowWhite", "imgSnowWhite", "imgBeautyBest", "imgMermaid", "imgSnowWhite","imgSnowWhite", "imgBeautyBest", "imgMermaid", "imgSnowWhite"]
    
    enum FooterSheetAnimateType {
        case down
        case up
        
        var constant: CGFloat {
            switch self {
            case .down: return -500
            case .up: return 0
            }
        }
        
        var isHidden: Bool {
            switch self {
            case .down: return true
            case .up: return false
            }
        }
    }
    
    private var gridCount = 3 {
        didSet {
            difference = CGFloat(gridCount + 1) * padding
        }
    }
    private var difference: CGFloat = 64
    private var padding: CGFloat = 16
  
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFooterBottomSheet()
    }
    
    // MARK: - Actions
    
    @IBAction func buyNowButtonAction(_ sender: UIButton) {
        self.animateFooterSheet()
    }
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        self.animateFooterSheet()
    }
    
    @IBAction func footerPanGestureAction(_ sender: UIPanGestureRecognizer) {
        self.animateFooterSheet()
    }
    
    @IBAction func footerTapGestureAction(_ sender: UITapGestureRecognizer) {
        self.animateFooterSheet()
    }
    
    
    // MARK: - Methods
    
    func configureFooterBottomSheet() {
        bottomConstraint.constant = -500
        footerBottomSheetView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        buyNowButton.applyCornerRadius(16)
        projectImageView.applyCornerRadius(16)
    }
    
    func animateFooterSheet(animateType: FooterSheetAnimateType = .down) {
        UIView.animate(withDuration: 0.3) {
            self.backView.isHidden = animateType.isHidden
            self.bottomConstraint.constant = animateType.constant
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - DataSource

extension ProjectsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectCell.identifier,
                                                      for: indexPath) as! ProjectCell
        cell.setImage(with: projects[indexPath.item])
        cell.onBookNowTap = { [weak self] image in
            guard let self else { return }
            self.projectImageView.image = image
            self.animateFooterSheet(animateType: .up)
        }
        return cell
    }
}

// MARK: - FlowLayout

extension ProjectsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: Int((collectionView.frame.width - difference)) / gridCount, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: padding, bottom: 20, right: padding)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        padding
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        padding
    }
}

