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
        
        // Get the contextRef
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        
        // Set the background fill color to WHITE
        context.setFillColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        
        context.fill(rect)
        
   
 
        // END-CODE-UOC-3
    }
 

}
