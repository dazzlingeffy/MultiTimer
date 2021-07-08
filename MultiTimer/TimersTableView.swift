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
    var timers = [TimerState(name: "a", seconds: 50), TimerState(name: "b", seconds: 60)]
    var cell: TimersCell!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .systemBackground
        register(TimersCell.self, forCellReuseIdentifier: "cell")
//        self.tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = self.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TimersCell
        cell.nameLabel.text = timers[indexPath.row].name
        cell.timeLabel.text = "\(timers[indexPath.row].min):\(timers[indexPath.row].sec)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (timers[indexPath.row].timer.isValid){
            timers[indexPath.row].timer.invalidate()
        } else {
            timers[indexPath.row].setTimer()
        }
    }
}

class TimersCell: UITableViewCell {
    var nameLabel = UILabel()
    var timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.frame = CGRect(x: 20, y: 0, width: self.frame.width / 2, height: 44)
        timeLabel.frame = CGRect(x: self.frame.width / 2 + 80, y: 0, width: self.frame.width / 2, height: 44)
        timeLabel.textColor = UIColor.placeholderText
        timeLabel.textAlignment = NSTextAlignment.right
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
