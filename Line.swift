//
//  Line.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/21/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class Line: UIView {
    
    var line = UIBezierPath()
    
    func graph(){
        line.move(to: .init(x: 0, y: bounds.height / 4.7))
        line.addLine(to: .init(x: bounds.width, y: bounds.height / 4.7))
        UIColor.init(named:"CampusPlateGreen")?.setStroke()
        line.lineWidth = 2
        line.stroke()
    }
    
    override func draw(_ rect: CGRect) {
         graph()
    }
    

}
