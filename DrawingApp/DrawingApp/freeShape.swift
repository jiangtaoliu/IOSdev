//
//  freeShape.swift
//  DrawingApp
//
//  Created by jett liu on 4/10/17.
//  Copyright © 2017 jett. All rights reserved.
//

import UIKit

class freeShape: baseShape {
    
    var lines: [Line] = []      // for free style line

    
    override func drawCondition(mylayer: CAShapeLayer) {

        let cPath = UIBezierPath()
        lines.append(Line(start: beginPoint, end: endPoint))
        beginPoint = endPoint
        
        for line in lines {
            cPath.move(to: line.start)
            cPath.addLine(to: line.end)
        }
        cPath.stroke()
        
        mylayer.path = cPath.cgPath
    }
    
    override func cleanLastLine() {
        lines.removeAll()
    }
    
}
