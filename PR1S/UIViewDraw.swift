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
    var  m_y_axis_max_value:Double = 0
    var  m_y_axis_step:Double = 0
    
    var  m_x_axis_labels:NSMutableArray?=nil
    var  m_y_values:NSMutableArray?=nil

    var topHeight:CGFloat = 0
      var bottomHeight:CGFloat = 0
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        // BEGIN-CODE-UOC-3
        
        // Set the background fill color to white (255,255,255)
       let context:CGContext = UIGraphicsGetCurrentContext()!;
        context.setFillColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        context.fill(rect)
        
        // We define limit coordinates and axis origins (0,0)
        let margin:CGFloat = 50
        let x0:CGFloat = margin
        let x1:CGFloat = rect.size.width - margin
        let y0:CGFloat = rect.size.height  - self.bottomHeight - margin
        let y1:CGFloat = self.topHeight + margin
        let origin = CGPoint(x:  x0, y: y0)
     
        // We draw axis lines
        let line:CGMutablePath  = CGMutablePath()
        context.setStrokeColor(red: 0.0, green: 0, blue: 0.0, alpha: 1.0)
        
        // Horizontal line
        line.move(to: origin)
        line.addLine(to: CGPoint(x:  x1, y: y0))
        context.addPath(line)
        
        // Vertical line
        line.move(to: origin)
        line.addLine(to: CGPoint(x:  x0, y: y1))
        context.addPath(line)
        
       /* Y AXIS */
        
        
        // Calculate sizes
        let y_axis_segments:CGFloat = CGFloat((m_y_axis_max_value - m_y_axis_min_value ) / m_y_axis_step)
        let y_axis_segment:CGFloat = (y0 - y1) / y_axis_segments
        
        
        // We define text attributes
        let stringStyle = NSMutableParagraphStyle()
        stringStyle.alignment = .right
    
        let attributes = [
            NSAttributedString.Key.paragraphStyle: stringStyle
        ]
        
        var attributedString:NSAttributedString
        var textbox:CGRect
        var stringHeight:CGFloat
        var textY:CGFloat = y0
        var drawingY:CGFloat
        
        for i in stride(from: (m_y_axis_min_value + m_y_axis_step), through: m_y_axis_max_value,
                        by: m_y_axis_step) {
            
            
            attributedString = NSAttributedString(string : String(format: "%.0f", i), attributes: attributes)
            stringHeight = attributedString.size().height
            
            textY -= CGFloat(y_axis_segment)
            drawingY = textY - stringHeight / 2
            
            textbox = CGRect(x: 0, y: drawingY, width: x0 - 20, height: stringHeight)
            attributedString.draw(in: textbox)
                            
            line.move(to: CGPoint(x: x0 - 5, y : textY))
            line.addLine(to: CGPoint(x:  x0 + 5, y: textY))
            context.addPath(line)
                            
        }
        
        context.strokePath()
        
        /* X_AXIS */
        
        // Calculate sizes
        let x_axis_segment:CGFloat = (x1 - x0) / CGFloat(m_x_axis_labels?.count ?? 1)
        
        var stringWidth:CGFloat
        var drawingX:CGFloat
        
        for label in m_x_axis_labels ?? NSMutableArray() {
            
        }
        // END-CODE-UOC-3
    }

}
