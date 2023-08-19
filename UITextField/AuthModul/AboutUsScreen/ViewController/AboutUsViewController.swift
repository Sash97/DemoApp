//
//  AboutUsViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 13.06.23.
//

import UIKit

struct Stuff {
    var categoryName: String // Example: Programmers
    var persons: [Person] // Jobs, Bil Gates, ...
}

struct Experience {
    let title: String
    let description: String
}

struct Person {
    var profession: String? = nil
    let imageName: String
    let name: String
    var isSelected: Bool = false
    var stringURL: String? = nil // homework
    var experiencies: [Experience] = []
}

class AboutUsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var aboutUsTableView: UITableView!
    
    // MARK: - Properties
    
    private var isEditButtonActive = false {
        didSet {
            configureEditRightItem(isActive: isEditButtonActive)
        }
    }
    
//    private var persons: [Person] =
//    [
//        .init(imageName: "person1", name: "John Smith"),
//        .init(imageName: "person2", name: "Bethoven van Ludvig"),
//        .init(imageName: "person3", name: "Stive Jobs"),
//        .init(imageName: "person1", name: "John Smith"),
//        .init(imageName: "person2", name: "Bethoven van Ludvig"),
//        .init(imageName: "person3", name: "Stive Jobs"),
//        .init(imageName: "person2", name: "Bethoven van Ludvig"),
//        .init(imageName: "person3", name: "Stive Jobs"),
//        .init(imageName: "person1", name: "John Smith"),
//        .init(imageName: "person1", name: "John Smith"),
//        .init(imageName: "person2", name: "Bethoven van Ludvig"),
//        .init(imageName: "person2", name: "Bethoven van Ludvig"),
//        .init(imageName: "person3", name: "Stive Jobs"),
//        .init(imageName: "person3", name: "Stive Jobs"),
//        .init(imageName: "person4", name: "Miban Grumenq")
//    ]
    
    private var stuff: [Stuff] =
    [
        .init(categoryName: "Programmers",
              persons:
                [
                    .init(profession: "iOS Developer",
                          imageName: "person1",
                          name: "John Smith",
                          experiencies:
                            [
                                .init(title: "Current Projects", description: "4"),
                                .init(title: "Houres Worked", description: "80"),
                                .init(title: "Upgrades Stage", description: "1"),
                                .init(title: "Upgrades Cost", description: "$923"),
                                .init(title: "Nationality", description: "Armenian")
                            ]),
                    .init(imageName: "person2", name: "Bethoven van Ludvig"),
                    .init(imageName: "person3", name: "Stive Jobs"),
                    .init(imageName: "person4", name: "Miban Grumenq")
                ]),
        .init(categoryName: "Managers",
              persons:
                [
                    .init(imageName: "person1", name: "John Smith"),
                    .init(imageName: "person2", name: "Bethoven van Ludvig"),
                    .init(imageName: "person3", name: "Stive Jobs"),
                    .init(imageName: "person4", name: "Miban Grumenq")
                ])
    ]
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Staff"
        configureTableView()
        configureEditRightItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? ABNavigationController)?.configureNavigationBar(with: .dark)
//        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (navigationController as? ABNavigationController)?.configureNavigationBar(with: .light)
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Methods
    
    func configureTableView() {
        aboutUsTableView.dataSource = self
        aboutUsTableView.delegate = self
//        aboutUsTableView.contentInset = .init(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    func configureEditRightItem(isActive: Bool = false) {
        let editButton = UIBarButtonItem(title: isActive ? "Done" : "Edit",
                                           style: .plain,
                                           target: self,
                                           action: #selector(editButtonTapped))
        
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonTapped() {
        isEditButtonActive.toggle()
        aboutUsTableView.isEditing.toggle()
    }
    
    var previousOffset: CGFloat = 0.0
    var direction: Direction? = nil
}

enum Direction {
    case up
    case down
}

extension AboutUsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stuff.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stuff[section].persons.count
    }
    
    // TITLED HEADER
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        stuff[section].categoryName
//    }
    
    
    // FOOTER
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        30
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .green
//        return view
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ABSecondaryTitleView(title: stuff[section].categoryName,
                             subtitle: "TestProjectStuff",
                             textColor: .black,
                             backgroundColor: .systemGray6)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsCell", for: indexPath) as! AboutUsCell
        cell.personImageView.image = UIImage(named:  stuff[indexPath.section].persons[indexPath.row].imageName)
        cell.nameLabel.text = stuff[indexPath.section].persons[indexPath.row].name
        
        let isSelected = stuff[indexPath.section].persons[indexPath.row].isSelected
        cell.backView.backgroundColor = isSelected ? .red : .white
        print("DEBUG: --- \(indexPath) ---")
        return cell
    }
}

extension AboutUsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Get the current content offset of the scroll view
        let currentOffset = scrollView.contentOffset.y
        
        // Compare the current and previous offset to determine the scrolling direction
        if currentOffset > previousOffset {
            // Scrolling downwards
            direction = .down
            print("Scrolling downwards")
        } else if currentOffset < previousOffset {
            // Scrolling upwards
            direction = .up
            print("Scrolling upwards")
        }
        
        // Update the previous offset with the current offset
        previousOffset = currentOffset
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard direction == .down else { return }
        cell.alpha = 0
        cell.transform = .init(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        stuff[sourceIndexPath.section].persons.swapAt(sourceIndexPath.row, destinationIndexPath.row)
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            tableView.beginUpdates()
            self.stuff[indexPath.section].persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let facebook = UIContextualAction(style: .normal, title: "") { _, _, _ in
            let url = URL(string: "https://facebook.com/adjashdak/ajsdhakj")!
            UIApplication.shared.open(url)
        }
        facebook.backgroundColor = .white
        facebook.image = UIImage(named: "icFacebook")
        
        let twitter = UIContextualAction(style: .normal, title: "") { _, _, _ in
            UIApplication.shared.open(URL(string: "https://twitter.com")!)
        }
        twitter.backgroundColor = .white
        twitter.image = UIImage(named: "icTwitter")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [facebook, twitter])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
//        if indexPath.row % 2 == 1 {
//            return 120
//        } else {
//            return 220
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stuff[indexPath.section].persons[indexPath.row].isSelected.toggle()
        let cell = tableView.cellForRow(at: indexPath) as! AboutUsCell
        let isSelected = stuff[indexPath.section].persons[indexPath.row].isSelected
        cell.backView.backgroundColor = isSelected ? .red : .white
        
        let person = stuff[indexPath.section].persons[indexPath.row]
        
        showScreen(with: .details(model: person))
    }
}
