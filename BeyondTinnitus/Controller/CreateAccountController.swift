//
//  CreateAccountController.swift
//  BeyondTinnitus
//
//  Created by Vincent Gentile on 11/21/16.
//  Copyright © 2016 teamMedApp. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountController: UIViewController {
    

    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var uid: UITextField!
    
    @IBAction func createAccount() {
        let _ = FIRDatabase.database().reference()
        FIRAuth.auth()?.createUser(withEmail: uid.text!, password: pwd.text!){ (user, error) in
            // ...
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
