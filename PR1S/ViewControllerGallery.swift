//
//  ViewControllerGallery.swift
//  PR2S
//
//  Created by Javier Salvador Calvo on 14/10/16.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ViewControllerGallery: UIViewController {
    
    @IBOutlet weak var  m_loader:UIActivityIndicatorView?
    
    var m_next_index:Int = 0
    var m_num_images:Int = 0
    var m_total_images:Int = 0
    
    var m_str_json:String = ""
    
    var m_images:NSMutableArray?=nil
    var m_views:NSMutableArray?=nil
    
    
    var m_timer:Timer?=nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // BEGIN-CODE-UOC-4
        
        /*
 
            "[\"http:einfmlinux1.uoc.edu/devios/media/i1.jpg\",\"
            http:einfmlinux1.uoc.edu/devios/media/i2.jpg\",\"
            http:einfmlinux1.uoc.edu/devios/media/i3.jpg\"]"
 */
        
       
        
        
        // END-CODE-UOC-4
        

    }
    
    
    @objc func AnimateRec(_ timer:Timer)
    {
        
        // BEGIN-CODE-UOC-7
        
       
        
        
        // END-CODE-UOC-7
        
    }
    
    
    @objc func CreateViews()
    {
        // BEGIN-CODE-UOC-6
        
      
        
        
        
         // END-CODE-UOC-6
    
    }
    
 
    
    
    func OpenImage(str_url:String)
    {
         // BEGIN-CODE-UOC-5
    
       
        
        
         // END-CODE-UOC-5
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
