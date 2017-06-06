//
//  ViewController.swift
//  DrawingApp
//
//  Created by jett liu on 3/23/17.
//  Copyright © 2017 jett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var shapes = [freeShape(), lineshape(), rectShape(), circleShape(), triangleShape(), clearShape()]
    var bShape: baseShape?
    
    var startPoint : CGPoint = CGPointFromString("0")
    var layer : CAShapeLayer?
    var myLayers: [CAShapeLayer] = []
    
    @IBOutlet weak var divImage: UIImageView!
    
    enum Color : Int{
        case orange = 0
        case blue
        case purple
        case green
        case yellow
        case red
        case magenta
    }
    enum Shape : Int{
        case Free = 10
        case Ecliple
        case Square
        case Line
        case Triangle
        case Eraser
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bShape = shapes[0]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedColor : UIColor = UIColor.black
    @IBAction func SelectColor(_ sender: UIButton) {
        let tag = sender.tag
        switch tag
        {
        case Color.orange.rawValue:
            selectedColor = UIColor.orange
        case Color.blue.rawValue:
            selectedColor = UIColor.blue
        case Color.purple.rawValue:
            selectedColor = UIColor.purple
        case Color.green.rawValue:
            selectedColor = UIColor.green
        case Color.yellow.rawValue:
            selectedColor = UIColor.yellow
        case Color.red.rawValue:
            selectedColor = UIColor.red
        case Color.magenta.rawValue:
            selectedColor = UIColor.magenta
        default:
            selectedColor = UIColor.black
        }
    }
    
    var selectedShape : Int = 0
    @IBAction func SelectShape(_ sender: UIButton) {
        let tag = sender.tag
        switch tag
        {
        case Shape.Free.rawValue:
            self.bShape = shapes[0]
        case Shape.Ecliple.rawValue:
            self.bShape = shapes[3]
        case Shape.Square.rawValue:
            self.bShape = shapes[2]
        case Shape.Line.rawValue:
            self.bShape = shapes[1]
        case Shape.Triangle.rawValue:
            self.bShape = shapes[4]
        case Shape.Eraser.rawValue:
            self.bShape = shapes[5]
        default:
            self.bShape = shapes[0]
        }
    }
    
    var selectedWidth : Int = 1
    @IBAction func selectLineWidth(_ sender: UISlider) {
        selectedWidth = Int(sender.value)
    }
    
    @IBAction func undo(_ sender: UIButton) {
        if !myLayers.isEmpty {
            myLayers[myLayers.endIndex-1].removeFromSuperlayer()
            myLayers.removeLast()
        }
    }
    
    @IBAction func DeleteAll(_ sender: UIButton) {

        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to continue deleting all drawings", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { ACTION in
            for layer in self.myLayers {
                layer.removeFromSuperlayer()
            }
            self.myLayers = []
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        let image = UIImage(view: self.view)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began
        {
            startPoint = sender .location(in: sender.view)
            
            layer = CAShapeLayer()
            layer?.fillColor = selectedColor.cgColor
            layer?.strokeColor = selectedColor.cgColor
            layer?.lineWidth = CGFloat(selectedWidth)
            layer?.opacity = 0.5
            self.view.layer.addSublayer(layer!)
            myLayers.append(layer!)

            if let iShape = self.bShape {
                iShape.lastPoint = nil
                
                iShape.beginPoint = startPoint
                iShape.endPoint = iShape.beginPoint
            }
        }
        else if sender.state == .changed
        {
            startPoint = sender .location(in: sender.view)
            
            if let iShape = self.bShape {
                iShape.endPoint = startPoint
                iShape.drawCondition(mylayer: layer!)
            }
            
        }
        else if sender.state == .ended
        {
            if self.bShape == shapes[0]
            {
                self.bShape?.cleanLastLine()
            }
        }
    }
    
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
