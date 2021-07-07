//
//  ViewController.swift
//  MultiTimer
//
//  Created by ira on 07.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add screen title
        self.view.backgroundColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)
        let titleViewMargin: CGFloat = 80;
        let titleView = TitleView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: titleViewMargin))
        self.view.addSubview(titleView)
        
        // add addingTimersSection header
        let addTimerHeaderMargin = titleViewMargin + 20
        let setTimerHeader = HeaderView(frame: CGRect(x: 0, y: addTimerHeaderMargin, width: self.view.frame.width, height: 45), title: "Добавление таймеров")
        self.view.addSubview(setTimerHeader)
        
        //add textfields
        let titleFieldMargin = addTimerHeaderMargin + 65
        let timerTextFields = TimerTextFieldsView(frame: CGRect(x: 0, y: titleFieldMargin, width: self.view.frame.width - 20, height: 400))
        timerTextFields.center.x = self.view.center.x
        self.view.addSubview(timerTextFields)
        
        // add timersSection header
        let timersHeaderMargin = titleFieldMargin + 220
        let timersHeader = HeaderView(frame: CGRect(x: 0, y: timersHeaderMargin, width: self.view.frame.width, height: 45), title: "Таймеры")
        self.view.addSubview(timersHeader)
        
        // add tableview
        let tableViewMargin = timersHeaderMargin + 45
        
    }

}
