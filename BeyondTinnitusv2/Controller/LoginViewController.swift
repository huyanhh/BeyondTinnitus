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
    
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var uid: UITextField!
    
    @IBAction func signIn() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "main") as? UINavigationController
            else { fatalError() }
        present(controller, animated: true, completion: nil)
        let _ = FIRDatabase.database().reference()
        FIRAuth.auth()?.signIn(withEmail: uid.text!, password: pwd.text!){ (user, error) in
            // ...
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
