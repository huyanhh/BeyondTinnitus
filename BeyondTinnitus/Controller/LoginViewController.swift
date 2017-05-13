//
//  LoginViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.

import UIKit
import Firebase
import AVFoundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var uid: UITextField!
    fileprivate var keyboardSize: CGRect?
    fileprivate var backgroundTapGesture: UITapGestureRecognizer?

    @IBAction func signIn() {
        guard let onboardVC = self.storyboard?.instantiateViewController(withIdentifier: "main") as? UINavigationController
            else { fatalError() }
        guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as? DashboardViewController
            else { fatalError() }
        
//        if !UserDefaults.standard.bool(forKey: "onboard") {
//            present(onboardVC, animated: true, completion: nil)
//        } else {
            present(dashboardVC, animated: true, completion: nil)
//        }
        
        let _ = FIRDatabase.database().reference()
        FIRAuth.auth()?.signIn(withEmail: uid.text!, password: pwd.text!){ (user, error) in
            // ...
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        if let userInfo: NSDictionary = aNotification.userInfo! as NSDictionary? {
            keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame.origin = CGPoint(x: 0, y: -self.keyboardSize!.height)
        }, completion: nil)
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        UIView.animate(withDuration: 0.1) {
            self.view.frame.origin = CGPoint(x: 0, y: 0)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(backgroundTapGesture!)
        hideKeyboardWhenTappedAround()
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(backgroundTapGesture!)
    }

}

