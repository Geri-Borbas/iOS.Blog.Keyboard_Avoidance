//
//  WireframeView.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 02/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


class WireframeView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        UIColor.label.setStroke()
        
        let frame = UIBezierPath(rect: rect)
        frame.stroke()
        
        let x = UIBezierPath()
        x.move(to: .init(x: rect.minX, y: rect.minY))
        x.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        x.move(to: .init(x: rect.minX, y: rect.maxY))
        x.addLine(to: .init(x: rect.maxX, y: rect.minY))
        x.stroke()
        
        let inset = UIBezierPath(rect: rect.inset(by: .init(
            top: rect.size.height * 0.05,
            left: rect.size.width * 0.05,
            bottom: rect.size.height * 0.05,
            right: rect.size.width * 0.05
        )))
        let dashPattern: [CGFloat] = [4.0, 4.0]
        inset.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        inset.stroke()
    }
}
