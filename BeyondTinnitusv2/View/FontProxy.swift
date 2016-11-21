//
//  FontProxy.swift
//  BeyondTinnitusv2
//
//  Created by Vincent Gentile on 11/20/16.
//  Copyright © 2016 teamMedApp. All rights reserved.
//

import UIKit

extension UIButton {
    var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
}

class Theme {
    static func apply() {
        applyToUIButton()
        applyToUITextField()
    }
    
    static func applyToUIButton(a: UIButton = UIButton.appearance()) {
        a.titleLabelFont = UIFont(name: "avenir", size:20.0)
    }
    static func applyToUITextField(b: UITextField = UITextField.appearance()) {
        b.font = UIFont(name: "avenir", size:20.0)
    }
    static func applyToUILabel(c: UILabel = UILabel.appearance()){
        c.font = UIFont(name: "avenir", size: c.font.pointSize)
    }
}

