//
//  UIView+Extensions.swift
//  Tracker
//
//  Created by Anastasiia Ki on 22.01.2025.
//

import UIKit

extension UIView {
    func addGradient() {
        self.layer.cornerRadius = 16

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.selection1.cgColor, UIColor.selection9.cgColor, UIColor.selection3.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = self.bounds
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1.5
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,
                                       cornerRadius: self.layer.cornerRadius).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.gray.cgColor
        
        gradientLayer.mask = shapeLayer
        
        if self.layer.sublayers?.count == nil {
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
