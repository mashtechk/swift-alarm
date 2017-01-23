//
//  ViewController.swift
//  Alarm
//
//  Created by Lasha Efremidze on 1/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let items: [Item] = [Item.make(title: "4:20 AM", subtitle: "4:20 AM", type: .am), Item.make(title: "4:20 PM", subtitle: "4:20 PM", type: .pm), Item.make(title: "4/20", subtitle: "4/20", type: .day)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .weedGreen
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.barTintColor = .weedGreen
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationItem.title = "420!"
        
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
        
        Alarm.start { accepted, error in
            if accepted {
                
            } else {
                print("Notification access denied.")
            }
        }
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: SwitchTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SwitchTableViewCell ?? SwitchTableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        var item = items[indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        cell.switchView.isOn = item.isOn
        cell.valueChangedBlock = { view in
            item.isOn = view.isOn
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController {

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Scheduled Alarms"
    }
    
}

//private class Cell: UITableViewCell {
//    
//    lazy var datePicker: UIDatePicker = { [unowned self] in
//        let picker = UIDatePicker()
//        picker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
//        self.contentView.addSubview(picker)
//        return picker
//    }()
//    
//    var valueChangedBlock: ((UIDatePicker) -> ())?
//    
//    @objc @IBAction func valueChanged(_ sender: UIDatePicker) {
//        valueChangedBlock?(sender)
//    }
//    
//}

struct Item {
    let title: String
    let subtitle: String
    let type: AlarmType
    var isOn: Bool {
        didSet {
            if isOn {
                type.schedule(title: "420 Get High 🙃") { error in
                    
                }
            } else {
                type.unschedule()
            }
        }
    }
    
    static func make(title: String, subtitle: String, type: AlarmType) -> Item {
        return Item(title: title, subtitle: subtitle, type: type, isOn: false)
    }
}

private class SwitchTableViewCell: UITableViewCell {
    
    lazy var switchView: UISwitch = { [unowned self] in
        let view = UISwitch()
        view.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        self.accessoryView = view
        return view
    }()
    
    var valueChangedBlock: ((UISwitch) -> Void)?
    
    @IBAction func valueChanged(sender: UISwitch) {
        self.valueChangedBlock?(sender)
    }
    
}

private extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
    
//    class var weedGreen: UIColor {
//        return UIColor(red: 120, green: 185, blue: 60)
//    }
    
//    class var weedGreen: UIColor {
//        return UIColor(red: 180, green: 236, blue: 81)
//    }

    class var weedGreen: UIColor {
        return UIColor(red: 66, green: 147, blue: 33)
    }
    
}
