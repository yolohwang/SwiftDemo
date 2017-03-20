//
//  Common.swift
//  SwiftDemo09
//
//  Created by YoloHwang on 17/3/16.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit
/*
 获得矩形最左边的x值 CGFloat CGRectGetMinX(CGRect rect);
 获取矩形中点的x值 CGFloat CGRectGetMidX(CGRect rect);
 获取矩形最右端的x值 CGFloat CGRectGetMaxX(CGRect rect);
 获取矩形最上端的y值 CGFloat CGRectGetMinY(CGRect rect);
 获取矩形中心点的y值 CGFloat CGRectGetMidY(CGRect rect);
 获取矩形最下端的y值 CGFloat CGRectGetMaxY(CGRect rect);
 获取矩形宽度 CGFloat CGRectGetWidth(CGRect rect);
 获取矩形高度 CGFloat CGRectGetHeight(CGRect rect);
 判断两个点是否相等 bool CGPointEqualToPoint(CGPoint point1, CGPoint point2);
 判断两个尺寸是否相等 bool CGSizeEqualToSize(CGSize size1, CGSize size2);
 判断两个矩形是否相等 bool CGRectEqualToRect(CGRect rect1, CGRect rect2);
 */
let screenRect = UIScreen.main.bounds
let generalFrame = CGRect (x: 0, y: 0, width: screenRect.width/2, height: screenRect.height/4)
let generalCenter = CGPoint (x: screenRect.midX, y: screenRect.midY - 50)

func drawRectView(_ color: UIColor,frame: CGRect,center: CGPoint) -> UIView {
    let view = UIView (frame: frame)
    view.backgroundColor = color
    view.center = center
    return view
}

func drawCircleView() -> UIView {
    //UIBezierPath的使用
    //1.创建path 2.添加路径到path 3.将path绘制出来
    //arcCenter, 位置 半径 起始角 结束角 顺时针
    let  path = UIBezierPath.init(arcCenter: generalCenter, radius: CGFloat(30), startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2), clockwise: true)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    
    //填充颜色
    shapeLayer.fillColor = UIColor.red.cgColor
    //边框颜色
    shapeLayer.strokeColor = UIColor.blue.cgColor
    shapeLayer.lineWidth = 3.0
    
    let view = UIView()
    view.layer.addSublayer(shapeLayer)
    return view
}

func showAlert(_ title: String, message: String, actionTitle: String) {
    let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction (title: actionTitle, style: .default, handler: nil))
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
}

