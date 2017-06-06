//
//  baseShape.swift
//  DrawingApp
//
//  Created by jett liu on 4/10/17.
//  Copyright © 2017 jett. All rights reserved.
//

import CoreGraphics
import UIKit

protocol PaintShape {
    
    func drawCondition(mylayer: CAShapeLayer)
}

class baseShape : NSObject, PaintShape {
    var beginPoint: CGPoint!
    var endPoint: CGPoint!
    var lastPoint: CGPoint?
    
    var strokeWidth: CGFloat!
    
    func drawCondition(mylayer: CAShapeLayer) {
        assert(false, "must implements in subclass.")
    }
    func cleanLastLine () {
        assert(false, "for free line using")
    }
}

