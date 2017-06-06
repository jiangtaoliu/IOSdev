//
//  lineShape.swift
//  DrawingApp
//
//  Created by jett liu on 4/10/17.
//  Copyright © 2017 jett. All rights reserved.
//

import UIKit

class lineshape: baseShape {
    
    override func drawCondition(mylayer: CAShapeLayer) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        aPath.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
        aPath.close()
        aPath.stroke()
        mylayer.path = aPath.cgPath
    }
}
