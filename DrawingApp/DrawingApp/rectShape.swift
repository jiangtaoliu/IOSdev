//
//  rectShape.swift
//  DrawingApp
//
//  Created by jett liu on 4/10/17.
//  Copyright © 2017 jett. All rights reserved.
//

import UIKit

class rectShape: baseShape {
    
    override func drawCondition(mylayer: CAShapeLayer) {
        mylayer.path = (UIBezierPath(rect:CGRect(origin: CGPoint(x: min(beginPoint.x, endPoint.x), y: min(beginPoint.y, endPoint.y)),
                               size: CGSize(width: abs(endPoint.x - beginPoint.x), height: abs(endPoint.y - beginPoint.y))))).cgPath
    }
}
