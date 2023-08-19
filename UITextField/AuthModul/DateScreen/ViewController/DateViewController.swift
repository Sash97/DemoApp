//
//  DateViewController.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 04.07.23.
//

import UIKit

class DateViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var dateTextField: UITextField!
    
    // MARK: - Properties
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(handlPickerValueChanged(datePicker:)), for: .valueChanged)
        datePicker.datePickerMode = .dateAndTime
        datePicker.frame.size = .init(width: 0, height: 400)
        self.dateTextField.inputView = datePicker
        return datePicker
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
    }
    
    // MARK: - Methods
    
    @objc func handlPickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let dateString = dateFormatter.string(from: datePicker.date)
        dateTextField.text = dateString
    }
    
    func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
    }
}
