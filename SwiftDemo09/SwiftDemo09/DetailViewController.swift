//
//  DetailViewController.swift
//  SwiftDemo09
//
//  Created by YoloHwang on 17/3/16.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    public var animationStr = ""
    var animateView: UIView!
    let duration = 2.0
    let delay = 0.2
    let scale = 1.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "A"
        setupRect()
        
    }
    
    fileprivate func setupRect() {
        if animationStr == "BezierCurve Position" {
            animateView = drawCircleView()
        } else if animationStr == "View Fade In" {
            animateView = UIImageView (image: UIImage (named: "whatsapp"))
            animateView.frame = generalFrame
            animateView.center = generalCenter
        } else if animationStr == "Gaea" {
          return
        }
        else {
            animateView = drawRectView(.red, frame: generalFrame, center: generalCenter)
        }
        view.addSubview(animateView)
    }
    @IBAction func nimateClick(_ sender: Any) {
        switch animationStr {
        case "2-Color":
            changeColor(.green)
        case "Simple 2D Rotation":
            rotateView(M_PI)
        case "Multicolor":
            multiColor(.red, .blue)
        case "Multi Point Position":
            multiPosition(CGPoint (x: self.animateView.frame.origin.x, y: 100), CGPoint (x: self.animateView.frame.origin.x, y: 350))
        case "BezierCurve Position":
            var controlPoint1 = self.animateView.center
            controlPoint1.y -= 125
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40
            controlPoint2.y -= 125
            var endPoint = self.animateView.center
            endPoint.x += 75
            
            curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
        case "Color and Frame Change":
            let currentFrame = self.animateView.frame
            //insetBy 就是OC里的 CGRectInset，dx 是x ＋ dx width - 2*dx，dy 是y ＋ dy height - 2*dy
            let frame1 = currentFrame.insetBy(dx: -30, dy: -50)
            let frame2 = frame1.insetBy(dx: 10, dy: 15)
            let frame3 = frame2.insetBy(dx: -5, dy: -10)
            print(currentFrame,frame1,frame2,frame3)
            /*
            (103.5, 226.0, 207.0, 184.0)
            (73.5, 176.0, 267.0, 284.0)
            (83.5, 191.0, 247.0, 254.0)
            (68.5, 171.0, 277.0, 294.0)
            */
            colorFrameChange(frame1, frame2, frame3, .red, .green, .blue)
        case "View Fade In":
            viewFadeIn()
        case "Pop":
            pop()
        case "Gaea":
            Gaea()
            
        default:
            showAlert("Hwang", message: "Yolo", actionTitle: "YY")
        }
        
    }
    
    // MARK: - Private methods for Aimations
    fileprivate func changeColor(_ color: UIColor) {
       
        UIView.animate(withDuration: duration) { 
            self.animateView.backgroundColor = color
        }
    }
    fileprivate func rotateView(_ float: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: .repeat, animations: {
            self.animateView.transform = CGAffineTransform (rotationAngle: CGFloat(float))
        }, completion: nil)
    }
    
    fileprivate func multiColor(_ color1: UIColor,_ color2: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = color1
        }) { (Bool) in
            self.changeColor(color2)
        }
    }
    fileprivate func multiPosition(_ point1: CGPoint,_ point2: CGPoint) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.frame.origin = point1
        }) { (finished) in
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.frame.origin = point2
            }, completion: { (finished) in
                //self.animateView.frame.origin = point1
            })
        }
    }
    fileprivate func colorFrameChange(_ frame1: CGRect,_ frame2: CGRect,_ frame3: CGRect,_ color1: UIColor,_ color2: UIColor,_ color3: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = color1
            self.animateView.frame = frame1
        }) { (finished) in
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.backgroundColor = color2
            }, completion: { (finished) in
                UIView.animate(withDuration: self.duration, animations: {
                    self.animateView.backgroundColor = color3
                    self.animateView.frame = frame3
                }, completion: nil)
            })
        }
        
    }
    fileprivate func viewFadeIn() {
        
    }
    fileprivate func pop() {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.transform = CGAffineTransform (scaleX: CGFloat(self.scale), y: 2)
        }) { (finished) in
            UIView.animate(withDuration: self.duration, animations: {
                //self.animateView.transform = CGAffineTransform (scaleX: 1, y: 1)
                //回到执行scale之前的原点
                self.animateView.transform = CGAffineTransform.identity
            })
        }
        
    }
    fileprivate func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.animateView.center)
        /*
         endPoint:曲线的终点
         controlPoint1:画曲线的第一个基准点
         controlPoint2:画曲线的第二个基准点
         */
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        
        let anim = CAKeyframeAnimation (keyPath: "position")
        anim.path = path.cgPath
        anim.duration = self.duration
        self.animateView.layer.add(anim, forKey: "animate")
        self.animateView.center = endPoint
    }
    
    fileprivate func Gaea() {
        
        

        
        let shape = CAShapeLayer()
        shape.lineWidth = 6
//        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = kCALineCapRound
        
        let radius = 50
        let clockwise = true
        let path = UIBezierPath.init(arcCenter: generalCenter, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2), clockwise: clockwise)
        shape.path = path.cgPath
        self.view.layer.addSublayer(shape)
        
        shape.strokeEnd = 0
        
//        let locations:[CGFloat] = [0.0,0.25,0.5,0.75]
//        let colors = [UIColor.red,UIColor.green,UIColor.green,UIColor.yellow]
        //let colorspace = CGColorSpaceCreateDeviceRGB()
        //let gradient = CGGradient.init(colorsSpace: colorspace, colors: colors, locations: locations)
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view1.bounds
//        gradientLayer.colors = colors
//        gradientLayer.locations = locations as [NSNumber]?
//        gradientLayer.startPoint = CGPoint (x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint (x: 0, y: 1)
//
//        shape.addSublayer(gradientLayer)
//        gradientLayer.mask = shape
//
//        
//
//        let progressLayer = CAShapeLayer()
//        progressLayer.frame = view1.bounds
//        progressLayer.fillColor = UIColor.clear.cgColor
//        
//        progressLayer.strokeColor = UIColor.blue.cgColor
//        progressLayer.lineWidth = 6.0
//        progressLayer.strokeEnd = 100
//        progressLayer.lineCap = kCALineCapRound
//        progressLayer.path = path.cgPath
//        
//        gradientLayer.mask = progressLayer
//        self.view.layer.addSublayer(gradientLayer)
        
        
        let rotate = CABasicAnimation (keyPath: "strokeEnd")
        rotate.fromValue = 0
        rotate.toValue = 1
        rotate.duration = 5
        shape.add(rotate, forKey: nil)
        shape.strokeEnd = 1
    }
}







