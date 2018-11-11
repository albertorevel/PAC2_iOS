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

    var m_top_padding:Double = 0
    var m_bottom_padding:Double = 0
    var m_left_padding:Double = 0
    var m_right_padding:Double = 0
    
    
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
        // We use margin/2 at top and at the left because there's no labels
        let margin:Double = 50
        let x0:Double = self.m_left_padding + margin
        let x1:Double = Double(rect.size.width) - self.m_right_padding - margin / 2
        let y0:Double = Double(rect.size.height)  - self.m_bottom_padding - margin
        let y1:Double = self.m_top_padding + margin / 2
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
        
        let y_ratio =  (y0 - y1) / (m_y_axis_max_value - m_y_axis_min_value)
        
        // We define text attributes
        let stringStyle = NSMutableParagraphStyle()
        stringStyle.alignment = .right
    
        let attributes = [
            NSAttributedString.Key.paragraphStyle: stringStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)
        ]
        
        var attributedString:NSAttributedString
        var textbox:CGRect
        var stringHeight:Double
        var newY:Double = y0
        var drawingY:Double
        
        for i in stride(from: (m_y_axis_min_value + m_y_axis_step), through: m_y_axis_max_value,
                        by: m_y_axis_step) {
            
            
            attributedString = NSAttributedString(string : String(format: "%.0f", i), attributes: attributes)
            stringHeight = Double(attributedString.size().height)
            
            newY = Double(origin.y) - y_ratio * i
            drawingY = newY - stringHeight / 2
            
            textbox = CGRect(x: 0, y: drawingY, width: x0 - 10, height: stringHeight)
            attributedString.draw(in: textbox)
                            
            line.move(to: CGPoint(x: x0 - 5, y : newY))
            line.addLine(to: CGPoint(x:  x0 + 5, y: newY))
            context.addPath(line)
                            
        }
        
        /* X_AXIS */
        
        // Calculate sizes
        let x_axis_segment:Double = (x1 - x0) / (Double(m_x_axis_labels?.count ?? 1) + 1.0 )
        var stringWidth:Double
        var newX:Double = x0
        var drawingX:Double
        var xCoordinates:Array<Double> = []
        var element:Int
        
        for i in 0...((m_x_axis_labels?.count ?? 1) - 1) {
            
            element = (m_x_axis_labels?.object(at: i) ?? 0 ) as! Int
            attributedString = NSAttributedString(string : String(element), attributes: attributes)
            stringWidth = Double(attributedString.size().width)
            stringHeight = Double(attributedString.size().height)
            
            newX = Double(origin.x) + Double(i + 1) * x_axis_segment
            // We store x coordinates in order to
            xCoordinates.append(newX)
            
            drawingX = newX - stringWidth / 2
            drawingY = y0 + stringHeight
            
            textbox = CGRect(x: drawingX, y: drawingY, width: stringWidth, height: stringHeight)
            attributedString.draw(in: textbox)
            
            line.move(to: CGPoint(x: newX, y : y0))
            line.addLine(to: CGPoint(x:  newX, y: y0 + 5))
            context.addPath(line)
        }
        
        context.strokePath()
        
        // draw rectangles
        
        let barwidth = x_axis_segment * ( 3 / 4 )
        var valueBar:CGRect
        var xIni:CGFloat = 0.0
        var barHeight:Double = 0.0
        context.setFillColor(red: 0.0, green: 0.0, blue: 255.0, alpha: 1.0)
        
        for i in 0...((m_y_values?.count ?? 1) - 1) {
            
            xIni = CGFloat(xCoordinates[i] - barwidth / 2)
            barHeight = (m_y_values?.object(at: i) as! Double) * y_ratio
            
            
            valueBar = CGRect(origin: CGPoint(x: xIni, y: origin.y),
                              size: CGSize(width: barwidth, height: -barHeight))
            
            context.addRect(valueBar)
            
        }
        
        context.fillPath()
        // END-CODE-UOC-3
    }

}
