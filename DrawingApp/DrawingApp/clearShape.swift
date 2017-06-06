//
//  clearShape.swift
//  DrawingApp
//
//  Created by jett liu on 4/10/17.
//  Copyright © 2017 jett. All rights reserved.
//

import UIKit

class clearShape: freeShape {
    
    override func drawCondition(mylayer: CAShapeLayer) {
        mylayer.fillColor = UIColor.white.cgColor
        mylayer.strokeColor = UIColor.white.cgColor
        mylayer.opacity = 1
        super.drawCondition(mylayer: mylayer)
    }
}
