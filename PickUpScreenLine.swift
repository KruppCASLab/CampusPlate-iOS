//
//  PickUpScreenLine.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/22/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PickUpScreenLine: UIView {
    
    var line = UIBezierPath()
        
    func graph(){
        line.move(to: .init(x: 0, y: bounds.height / 2.4))
        line.addLine(to: .init(x: bounds.width, y: bounds.height / 2.4))
        UIColor.init(named: "CampusPlateGreen")?.setStroke()
        line.lineWidth = 2
        line.stroke()
    }
        
    override func draw(_ rect: CGRect) {
            graph()
    }
}
