//
//  SettingsViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2017. 5. 12..
//
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let rowData = ["Purchase subscription", "Restore Purchases"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sectionData[section]
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = rowData[indexPath.row]
        
        if indexPath.row == 0 {
            cell.textLabel?.textColor = .red
        }
        
        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
