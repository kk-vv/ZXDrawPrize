//
//  ZXSectorModel.swift
//  ZXStructs
//
//  Created by JuanFelix on 2018/4/12.
//  Copyright © 2018年 screson. All rights reserved.
//

import Foundation
import UIKit

class ZXPrizeContentLayer: NSObject {
    var zxshape = CAShapeLayer()
    fileprivate var zxprizeImage = CALayer()
    fileprivate var zxmarkImage = CALayer()
    //fileprivate var zxmarkLayer = CAShapeLayer()
    
    override init() {
        super.init()

        zxshape.masksToBounds = true
        
        zxprizeImage.contentsGravity = kCAGravityResizeAspect
        zxprizeImage.contentsScale = UIScreen.main.scale
        zxprizeImage.masksToBounds = true
        
        zxmarkImage.contentsGravity = kCAGravityResizeAspect
        zxmarkImage.contentsScale = UIScreen.main.scale
        zxmarkImage.masksToBounds = true
        
        zxshape.addSublayer(zxprizeImage)
        zxshape.addSublayer(zxmarkImage)
    }
    
    func setPrizeImage(_ image: UIImage) {
        self.zxprizeImage.contents = image.cgImage
    }
    
    func setMarkImage(_ image: UIImage?) {
        self.zxmarkImage.contents = image?.cgImage
        if image != nil {
            self.zxprizeImage.opacity = 0.35
        }
    }
}

class ZXSectorModel {
    ///奖品格子个数
    static var sectorCount  = 8
    ///半径
    static var circleRadius: CGFloat = 150
    ///中心圆半径 == 0 扇形  > 0 拱形
    static let centerRadius: CGFloat = 0
    ///扇形夹角
    static var sectorRadian: CGFloat { return (CGFloat.pi * 2) / CGFloat(self.sectorCount) }
    
    static func zxSectorLayers() -> [ZXPrizeContentLayer] {
        var layers: Array<ZXPrizeContentLayer> = []
        let radian = sectorRadian / 2
        let rectWidth_2 = circleRadius * tan(radian)
        let xValue = rectWidth_2 - circleRadius * sin(radian)
        let yValue = circleRadius - circleRadius * cos(radian)
        
        let ccXValue = centerRadius * sin(radian)
        let ccYValue = centerRadius * cos(radian)
        
        let startPoint = CGPoint(x: xValue, y: yValue)
        
        for index in 0..<self.sectorCount {
            let zxShapeLayer = ZXPrizeContentLayer()
            let spLayer = zxShapeLayer.zxshape //
            
            spLayer.frame = CGRect(x: 0, y: 0, width: rectWidth_2 * 2, height: circleRadius)
            zxShapeLayer.zxprizeImage.frame = CGRect(x: 0, y: 0, width: rectWidth_2 * 2, height: circleRadius / 2)
            zxShapeLayer.zxmarkImage.frame = CGRect(x: 0, y: 30, width: rectWidth_2 * 2, height: 30)
            
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addArc(withCenter: CGPoint(x: rectWidth_2, y: circleRadius), radius: circleRadius, startAngle: CGFloat.pi / 2 * 3 - radian , endAngle: CGFloat.pi / 2 * 3 + radian , clockwise: true)
            path.addLine(to: CGPoint(x: rectWidth_2 + ccXValue, y: circleRadius - ccYValue))
            path.addArc(withCenter: CGPoint(x: rectWidth_2, y: circleRadius), radius: centerRadius, startAngle: CGFloat.pi / 2 * 3 + radian, endAngle: CGFloat.pi / 2 * 3 - radian, clockwise: false)
            path.close()
            
            spLayer.path = path.cgPath
            let tempR = circleRadius / 2
            let x = circleRadius + tempR * sin(sectorRadian * CGFloat(index))
            let y = circleRadius - tempR * cos(sectorRadian * CGFloat(index))
            spLayer.position = CGPoint(x: x, y: y)
            spLayer.fillColor = UIColor.clear.cgColor
            spLayer.strokeColor = UIColor.clear.cgColor
            
            var transform = CATransform3DIdentity
            transform = CATransform3DMakeRotation(sectorRadian * CGFloat(index) , 0, 0, 1)
            spLayer.transform = transform
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            spLayer.mask = mask
            
            layers.append(zxShapeLayer)
        }
        return layers
    }
}
