//
//  WideButton.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit

class WideButton: UIButton {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        // Do what you want.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.beyond(color: .teal)
    }

}
