//
//  TimersTableView.swift
//  MultiTimer
//
//  Created by ira on 08.07.2021.
//

import UIKit

class TimersTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    static let instance = TimersTableView()
//    var timers = [TimerState]()
    static var timers = [TimerState]()
    var cell: TimersCell!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .systemBackground
        register(TimersCell.self, forCellReuseIdentifier: "cell")
        self.tableHeaderView = HeaderView(frame: CGRect(x: 0, y: 0,
                                                        width: self.frame.width,
                                                        height: 44), title: "Таймеры")
//        self.tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TimersTableView.timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = self.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TimersCell
        cell.nameLabel.text = TimersTableView.timers[indexPath.row].name
        cell.timeLabel.text = "\(TimersTableView.timers[indexPath.row].min):\(TimersTableView.timers[indexPath.row].sec)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (TimersTableView.timers[indexPath.row].timer.isValid){
            TimersTableView.timers[indexPath.row].timer.invalidate()
        } else {
            TimersTableView.timers[indexPath.row].setTimer()
        }
        self.sort()
        self.reloadData()
    }
    func removeTimer() {
        if TimersTableView.timers.count > 0 {
            TimersTableView.timers.removeLast()
        }
        print(TimersTableView.timers)
        self.reloadData()
    }
    
    func sort() {
        guard TimersTableView.timers.count > 1 else {
            return
        }
        
        for i in 0..<TimersTableView.timers.count - 1{
            for j in 0..<TimersTableView.timers.count - i - 1{
                if (TimersTableView.timers[j].seconds < TimersTableView.timers[j + 1].seconds){
                    let temp = TimersTableView.timers[j]
                    TimersTableView.timers[j] =  TimersTableView.timers[j + 1]
                    TimersTableView.timers[j + 1] = temp
                }
            }
        }
    }
}

class TimersCell: UITableViewCell {
    var nameLabel = UILabel()
    var timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width / 2, height: 44)
        timeLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 20, y: 0, width: UIScreen.main.bounds.width / 2, height: 44)
        timeLabel.textColor = UIColor.placeholderText
        timeLabel.textAlignment = NSTextAlignment.right
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
