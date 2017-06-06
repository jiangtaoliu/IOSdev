//
//  triangleshape.swift
//  DrawingApp
//
//  Created by jett liu on 4/10/17.
//  Copyright © 2017 jett. All rights reserved.
//

import UIKit

class triangleShape: baseShape {
    
    override func drawCondition(mylayer: CAShapeLayer) {
        let tPath = UIBezierPath()
        tPath.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        tPath.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
        tPath.addLine(to: CGPoint(x: (endPoint.x - 2*(endPoint.x-beginPoint.x)), y:endPoint.y))
        mylayer.path = tPath.cgPath
    }
}
