//
//  ATCALayerCateGories.swift
//  Athena
//
//  Created by GaoCheng.Zou on 2017/8/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func setBorderColorFromUIColor(_ color:UIColor ){
        self.borderColor = color.cgColor
    }
}

