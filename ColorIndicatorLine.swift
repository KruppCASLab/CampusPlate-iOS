//
//  ColorIndicatorLine.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/12/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class ColorIndicatorLine: UIView {
    
    var line = UIBezierPath()
    
    func graph(){
        line.move(to: .init(x: bounds.height / 5, y: 0))
        line.addLine(to: .init(x: bounds.width, y: bounds.height / 5))
        UIColor.green.setStroke()
        line.lineWidth = 2
        line.stroke()
    }
    
    override func draw(_ rect: CGRect) {
         graph()
    }
    

}
