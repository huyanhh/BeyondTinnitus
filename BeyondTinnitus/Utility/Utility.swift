//
//  Utility.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 22..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let backgroundTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(backgroundTapGesture)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
