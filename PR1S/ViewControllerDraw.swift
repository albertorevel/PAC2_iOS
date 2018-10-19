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
            
            var m_y_axis = list.value(forKey: "y-axis") as! NSMutableDictionary
            var m_x_axis_labels = list.value(forKey: "x-axis-labels") as! NSMutableArray
            var m_y_values = list.value(forKey: "y-values") as! NSMutableArray
            var m_min_value = m_y_axis.value(forKey: "min-value") as! Double
            var m_max_value = m_y_axis.value(forKey: "max-value") as! Double
            var m_step = m_y_axis.value(forKey: "step") as! Double

        } catch {
            print("Unexpected error: \(error).")
        }
        /*
        "{\"y-axis\":
            {\"min-value\":0.0,\"max-value\":700.0,\"step\":100.0},
         \"x-axislabels\":[2013,2014,2015],
         \"y-values\":[356,560,620]}"
        
        */
        
        
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
