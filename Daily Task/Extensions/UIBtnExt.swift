//
//  UIBtnExt.swift
//  Daily Task
//
//  Created by MEHEDI.R8 on 11/7/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.6, blue: 0.1411764706, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.6485026042, blue: 0.1411764706, alpha: 0.6067475818)
    }
}
