//
//  CALayer+Additions.swift
//  TodoApp
//
//  Created by Ugur Kilic on 10/04/2020.
//  Copyright © 2020 urklc. All rights reserved.
//

import QuartzCore
import UIKit

public extension CALayer {

    /// Applies default shadow to view
    func uk_applyShadow() {
        let path = UIBezierPath(rect: bounds)
        masksToBounds = false
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 2, height: 2)
        shadowOpacity = 0.4
        shadowPath = path.cgPath
    }
}
