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
        // Convertimos el JSON recuperado en una variable de tipo Data
        let m_data:Data = m_str_json.data(using: String.Encoding.utf8)!
        
        
        do {
            let list: NSMutableDictionary = try JSONSerialization.jsonObject(with: m_data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
            
            let m_y_axis = list.value(forKey: "y-axis") as! NSMutableDictionary
            
            // Values to populate m_view
            let m_x_axis_labels = list.value(forKey: "x-axis-labels") as! NSMutableArray
            let m_y_values = list.value(forKey: "y-values") as! NSMutableArray
            let m_y_axis_min_value = m_y_axis.value(forKey: "min-value") as! Double
            let m_y_axis_max_value = m_y_axis.value(forKey: "max-value") as! Double
            let m_y_axis_step = m_y_axis.value(forKey: "step") as! Double

            m_view = UIViewDraw()
            
            m_view?.m_x_axis_labels = m_x_axis_labels
            m_view?.m_y_values = m_y_values
            m_view?.m_y_axis_min_value = m_y_axis_min_value
            m_view?.m_y_axis_max_value = m_y_axis_max_value
            m_view?.m_y_axis_step = m_y_axis_step
        
        } catch {
            print("Unexpected error: \(error).")
        }
        /*
        "{\"y-axis\":
            {\"min-value\":0.0,\"max-value\":700.0,\"step\":100.0},
         \"x-axislabels\":[2013,2014,2015],
         \"y-values\":[356,560,620]}"
        
        */
        
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
