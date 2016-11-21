//
//  LoginViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    let ref = FIRDatabase.database().reference()
    
    @IBAction func signIn() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "main") as? UINavigationController
            else { fatalError() }
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
