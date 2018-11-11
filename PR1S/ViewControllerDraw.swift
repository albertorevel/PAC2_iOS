//
//  ViewControllerDraw.swift
//  PR2S
//
//  Created by Javier Salvador Calvo on 14/10/16.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ViewControllerDraw: UIViewController {

       
    
    var m_str_json:String = ""
    var m_view:UIViewDraw? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN-CODE-UOC-2
        // We convert JSON into a Data type variable
        let m_data:Data = m_str_json.data(using: String.Encoding.utf8)!
        
        
        do {
            // We read information stored in data
            let list: NSMutableDictionary = try JSONSerialization.jsonObject(with: m_data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
            
            let m_y_axis = list.value(forKey: "y-axis") as! NSMutableDictionary
            
            // We get the values to populate m_view
            let m_x_axis_labels = list.value(forKey: "x-axis-labels") as! NSMutableArray
            let m_y_values = list.value(forKey: "y-values") as! NSMutableArray
            let m_y_axis_min_value = m_y_axis.value(forKey: "min-value") as! Double
            let m_y_axis_max_value = m_y_axis.value(forKey: "max-value") as! Double
            let m_y_axis_step = m_y_axis.value(forKey: "step") as! Double

            m_view = UIViewDraw()
            
            // We populate m_view fields
            m_view?.m_x_axis_labels = m_x_axis_labels
            m_view?.m_y_values = m_y_values
            m_view?.m_y_axis_min_value = m_y_axis_min_value
            m_view?.m_y_axis_max_value = m_y_axis_max_value
            m_view?.m_y_axis_step = m_y_axis_step
        
        } catch {
            print("Unexpected error: \(error).")
        }
        
        // We get statusBar size and safeArea size (if available), in order to draw labels and
        // axis properly, and we set these sizes in view properties.
        let barHeight=self.navigationController?.navigationBar.frame.height ?? 0
        let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
        var topPadding = barHeight + statusBarHeight
        
        // If it's iOS 11 or higher, we get safe area sizes
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding += window?.safeAreaInsets.top ?? 0.0
            let bottomPadding = window?.safeAreaInsets.bottom
            let leftPadding = window?.safeAreaInsets.left
            let rightPadding = window?.safeAreaInsets.right
            m_view?.m_bottom_padding = Double(bottomPadding ?? 0)
            m_view?.m_left_padding = Double(leftPadding ?? 0)
            m_view?.m_right_padding = Double(rightPadding ?? 0)
        }
        
        m_view?.m_top_padding = Double(topPadding)
        
        // We add this View UIViewDraw to the controller's view.
        if (m_view != nil) {
            self.view = m_view
        }
        // END-CODE-UOC-2
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
