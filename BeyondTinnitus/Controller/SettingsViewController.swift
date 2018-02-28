//
//  SettingsViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2017. 5. 12..
//
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var restoreButton: UIBarButtonItem! {
    didSet {
      restoreButton.action = #selector(SettingsViewController.restoreTapped(_:))
    }
  }
  
  var products = [SKProduct]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(SettingsViewController.reload), for: .valueChanged)
    
    NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.handlePurchaseNotification(_:)),
                                           name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                           object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    reload()
  }
  
  func reload() {
    products = []
    
    tableView.reloadData()
    
    BeyondTinnitusPurchase.store.requestProducts{success, products in
      if success {
        self.products = products!
        self.tableView.reloadData()
      }
      
      self.tableView.refreshControl?.endRefreshing()
    }
  }
  
  func restoreTapped(_ sender: AnyObject) {
    BeyondTinnitusPurchase.store.restorePurchases()
  }
  
  func handlePurchaseNotification(_ notification: Notification) {
    guard let productID = notification.object as? String else { return }
    
    for (index, product) in products.enumerated() {
      guard product.productIdentifier == productID else { continue }
      
      tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
  }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  // DataSource
  @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
    
    let product = products[(indexPath as NSIndexPath).row]
    
    cell.product = product
    cell.buyButtonHandler = { product in
      BeyondTinnitusPurchase.store.buyProduct(product)
    }
    
    return cell
  }
}
