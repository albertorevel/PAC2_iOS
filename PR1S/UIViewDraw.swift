//
//  UIViewDraw.swift
//  PR2S
//
//  Created by Javier Salvador Calvo on 14/10/16.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class UIViewDraw: UIView {

    var  m_y_axis_min_value:Double = 0
    var  m_y_axis_max_value:Double=0
    var  m_y_axis_step:Double = 0
    
    var  m_x_axis_labels:NSMutableArray?=nil
    var  m_y_values:NSMutableArray?=nil

        
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        // BEGIN-CODE-UOC-3
        
        // Set the background fill color to white (255,255,255)
       let context:CGContext = UIGraphicsGetCurrentContext()!;
        context.setFillColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        context.fill(rect)
/*
        var r2:CGRect  = rect;
        r2.size.width = r2.size.width - 50
        r2.size.height = r2.size.height - 50
        
        r2.origin.x = (rect.size.width - r2.size.width) / 2
        r2.origin.y = (rect.size.height - r2.size.height) / 2
*/
        // Drawing axis
        
        /*
        // Set the circle fill color to black (0,0,0)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        let origin:CGPoint = CGPoint(x:  25 , y: 25)
        let x1 = rect.size.width - 25
        context.setLineWidth(3.0)
        
        context.move(to: CGPoint(x: 0.0, y: 0.0))
        context.addLine(to: CGPoint(x: 50, y: 50))
        context.strokePath()
        
*/
        /*
        let origin:CGPoint = CGPoint(x:  25 , y: 25)
        
        
        let linePath = UIBezierPath()
        linePath.lineWidth = 3
        
        linePath.move(to: origin)
        var x1 = rect.size.width - 25
        linePath.addLine(to: CGPoint(x: x1 , y: origin.y))
        
        linePath.close()
        linePath.stroke()
        
//        context.addLines(between: [origin,CGPoint(x:  rect.size.width - 25, y: origin.y)])
//        //If you want to fill it as well
//        aPath.fill()
        
        */
        
     
        
        let line:CGMutablePath  = CGMutablePath()
        
        // Horizontal line
        line.move(to: CGPoint(x: 25, y: 0))
        line.addLine(to: CGPoint(x:  25, y: 100))
        context.setFillColor(red: 0.0, green: 255.0, blue: 0.0, alpha: 1.0)
        context.addPath(line)
        context.addPath(line)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        /*
        // Vertical line
        line.move(to: origin)
        line.addLine(to: CGPoint(x:  origin.x, y: rect.size.height - 25))
        context.addPath(line)
        
        context.drawPath(using: CGPathDrawingMode.fill)
        */
        
        // END-CODE-UOC-3
    }
 

}
