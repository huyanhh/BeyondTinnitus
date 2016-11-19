//
//  DashboardViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let sectionData = [" "]
    fileprivate let rowData = [["Play with Music"],
                           ["Play with Spotify"],
                           ["Hello boys"],
                           ["Set Timer"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // We do [row][section] for now because we only have one section
        
//        if indexPath.row == 0 {
            cell.textLabel?.text = rowData[indexPath.row][indexPath.section]
//        }
        
        return cell
    }

    // Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            guard let musicAppURL = URL(string: "music://") else { fatalError("probably playing from simulator") }
            if UIApplication.shared.canOpenURL(musicAppURL) {
                UIApplication.shared.open(musicAppURL, options: [:], completionHandler: nil)
            }
        default:
            print("hi")
            break
        }
    }
    
}
