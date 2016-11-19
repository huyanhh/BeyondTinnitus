//
//  BeyondUIFont.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    dynamic var defaultFont: UIFont? {
        get { return self.font }
        set {
            let sizeOfOldFont = self.font.pointSize
            let fontNameOfNewFont = newValue?.fontName
            self.font = UIFont(name: fontNameOfNewFont!, size: sizeOfOldFont)
        }
    }
    
}
