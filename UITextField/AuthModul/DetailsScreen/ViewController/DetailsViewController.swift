//
//  DetailsViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 22.06.23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var parametrsTableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var upgradeButton: UIButton!
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var secondaryInfoLabel: UILabel!
    
    
    // MARK: - Propeties -
    
    var person: Person! 
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBackItem()
        updatePersonalInfo()
    }
    
    // MARK: - Methods
    
    private func updatePersonalInfo() {
        personImageView.image = UIImage(named: person.imageName)
        personNameLabel.text = person.name
        secondaryInfoLabel.text = "Stuff: " + person.name
        infoButton.setTitle(person.profession, for: .normal)
    }
    
    private func configureUI() {
        infoButton.applyCornerRadius(8)
        footerView.applyCornerRadius(24)
        upgradeButton.applyCornerRadius(24)
        infoCollectionView.dataSource = self
        infoCollectionView.delegate = self
        parametrsTableView.dataSource = self
        parametrsTableView.delegate = self
        navigationItem.hidesBackButton = true
    }
    
    private func configureBackItem() {
        let backImage = UIImage(named: "icRoundedBack")?
            .scaled(toSize: .init(width: 40, height: 40))?
            .withRenderingMode(.alwaysOriginal)
        
        let customButton = UIBarButtonItem(image: backImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = customButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func projectButtonAction(sender: UIButton) {
        showScreen(with: .projects)
    }
    
    @IBAction func developerButtonAction(sender: UIButton) {
        showScreen(with: .date)
    }
}

// MARK: - ParametrsTableViewDelegates

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        person.experiencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParametrCell", for: indexPath) as! ParametrCell
        cell.titleLabel.text = person.experiencies[indexPath.row].title
        cell.descriptionLabel.text = person.experiencies[indexPath.row].description
        return cell
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: - InfoCollectionViewDelegates

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        person.experiencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! InfoCell
        cell.titleLabel.text = person.experiencies[indexPath.row].title
        cell.descriptionLabel.text = person.experiencies[indexPath.row].description
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
}
