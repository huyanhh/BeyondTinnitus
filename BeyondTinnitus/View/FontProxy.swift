//
//  FontProxy.swift
//  BeyondTinnitus
//
//  Created by Vincent Gentile on 11/20/16.
//  Copyright © 2016 teamMedApp. All rights reserved.
//

import UIKit

extension UILabel {
    dynamic var defaultFont: UIFont? {
        get { return self.font }
        set {
            let sizeOfOldFont = self.font.pointSize
            let fontNameOfNewFont = newValue?.fontName
            self.font = UIFont(name: fontNameOfNewFont!, size: sizeOfOldFont)
        }
    }
    
}

extension UIButton {
    var defaultFont: UIFont! {
        get { return self.titleLabel?.font }
        set {
            let sizeOfOldFont = self.defaultFont.pointSize
            let fontNameOfNewFont = newValue?.fontName
            self.titleLabel?.font = UIFont(name: fontNameOfNewFont!, size: sizeOfOldFont)
        }
    }
}

struct Theme {
    static func apply() {
        applyToUIButton()
        applyToUITextField()
        applyToUILabel()
    }
    
    static func applyToUIButton(button: UIButton = UIButton.appearance()) {
        button.defaultFont = UIFont(name: "Avenir", size: 20.0)
    }
    static func applyToUITextField(text: UITextField = UITextField.appearance()) {
        text.font = UIFont(name: "Avenir", size: 20.0)
    }
    static func applyToUILabel(label: UILabel = UILabel.appearance()) {
        label.defaultFont =  UIFont(name: "Avenir", size: 15 /*doesn't matter*/)
    }
}

