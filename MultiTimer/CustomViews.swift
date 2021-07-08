//
//  CustomViews.swift
//  MultiTimer
//
//  Created by ira on 07.07.2021.
//

import UIKit

class TitleView: UIView {
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTitleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTitleView() {
        label.frame = CGRect(x: 0, y: 30, width: 150, height: 50)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.center.x = self.center.x
        label.text = "Мульти таймер"
        self.addSubview(label)
        self.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1).cgColor
    }
}

class HeaderView: UIView {
    var header = UILabel()
    let string: String
    
    init(frame: CGRect, title: String) {
        self.string = title
        super.init(frame: frame)
        self.createSetTimerHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSetTimerHeaderView() {
        header.frame = CGRect(x: 30, y: 0, width: 200, height: 45)
        header.text = self.string
        header.textColor = UIColor.placeholderText
        header.font = UIFont.systemFont(ofSize: 14)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 43, width: self.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor(red: 0.757, green: 0.757, blue: 0.765, alpha: 1).cgColor
        self.layer.addSublayer(bottomBorder)
        self.addSubview(header)
        self.backgroundColor = UIColor(red: 0.972, green: 0.973, blue: 0.972, alpha: 1)
    }
}

class TimerTextFieldsView: UIView, UITextFieldDelegate {
    var titleField = UITextField()
    var secondsField = UITextField()
    var addButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTimerTextFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTimerTextFields() {
        titleField.frame = CGRect(x: 20, y: 0, width: 280, height: 30)
        titleField.placeholder = "Название таймера"
        titleField.font = UIFont.systemFont(ofSize: 14)
        titleField.borderStyle = UITextField.BorderStyle.roundedRect
        titleField.delegate = self
        
        secondsField.frame = CGRect(x: 20, y: 50, width: 280, height: 30)
        secondsField.placeholder = "Время в секундах"
        secondsField.font = UIFont.systemFont(ofSize: 14)
        secondsField.borderStyle = UITextField.BorderStyle.roundedRect
        secondsField.keyboardType = .numberPad
        secondsField.delegate = self
        
        addButton.setTitle("Добавить", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        addButton.layer.cornerRadius = 20
        addButton.clipsToBounds = true
        addButton.frame = CGRect(x: 0, y: 110, width: self.frame.width, height: 80)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
        
        self.addSubview(titleField)
        self.addSubview(secondsField)
        self.addSubview(addButton)
    }

    @objc func addButtonTapped(sender: UIButton) {
        if (titleField.isFirstResponder) {
            titleField.resignFirstResponder()
        } else {
            secondsField.resignFirstResponder()
        }
        guard !(titleField.text == "") && !(secondsField.text == "") else {
            return
        }
        let newTimer = TimerState(name: titleField.text!, seconds: Int(secondsField.text!)!)
        TimersTableView.timers.append(newTimer)
        ViewController.tableView.sort()
        ViewController.tableView.reloadData()
        print("button tapped")
        titleField.text = ""
        secondsField.text = ""
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleField:
            secondsField.becomeFirstResponder()
            default:
                secondsField.resignFirstResponder()
            }
        return true
    }
}

