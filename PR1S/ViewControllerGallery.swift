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
        
        // Convertimos el JSON recuperado en una variable de tipo Data
        let m_data:Data = m_str_json.data(using: String.Encoding.utf8)!
        
        do {
            let list: NSMutableArray = try JSONSerialization.jsonObject(with: m_data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
            
            self.m_total_images = list.count
            self.m_images = NSMutableArray(capacity: self.m_total_images)
            self.m_views = NSMutableArray(capacity: self.m_total_images)
            var urlString:String
            
            for img in list {
                urlString = img as! String
                OpenImage(str_url: urlString)
            }
            
            self.m_loader?.startAnimating()
            
        } catch {
            print("Unexpected error: \(error).")
        }
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
        let uIImageView:UIImageView = self.m_views?.object(at: self.m_next_index) as! UIImageView
        
        let originPoint = self.view.frame.origin
        let originalFrameWidth = self.view.frame.size
        originPoint.y += (self.view.frame.size).width
        
        let newFrame:CGRect = CGRect(origin: originPoint, size: self.view.frame.size)
        
        uIImageView.frame = newFrame
        
        self.view.addSubview(uIImageView)
        
        newFrame.origin.y =
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            
        }, completion: { finished in
            self.m_next_index = (self.m_next_index + 1) % self.m_total_images
            
            self.m_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self
                , selector: #selector(self.AnimateRec), userInfo: nil, repeats: false)
        })
        
        
        
       
        // END-CODE-UOC-7
        
    }
    
    
    @objc func CreateViews()
    {
        // BEGIN-CODE-UOC-6
        
        for image in self.m_images! {
            let imageView:UIImageView = UIImageView(image: image as? UIImage)
            
            self.m_views?.add(imageView)
        }
        
        let uIImageView = self.m_views?.object(at: self.m_next_index) as! UIImageView
        
        self.view.addSubview(uIImageView)

        self.m_next_index = 1
        self.m_loader?.stopAnimating()
        
        
        
        self.m_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self
            , selector: #selector(AnimateRec), userInfo: nil, repeats: false)
         // END-CODE-UOC-6
    
    }
    
 
    
    
    func OpenImage(str_url:String)
    {
         // BEGIN-CODE-UOC-5
        
        var str1 = NSHomeDirectory()
        str1.append(str_url)
    
        let url:URL = URL(fileURLWithPath: str1)

        
        //        let url:URL = URL(string: str_url)!

        let request:URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        
        let session:URLSession = URLSession.shared
        
        let task:URLSessionDataTask = session.dataTask(with: request){
            (data, response, error) -> Void in
            
            if(data != nil && error == nil) {
                let image:UIImage = UIImage(data: data!)!
                
                self.m_images?.add(image)
                
                self.m_num_images += 1
                
                if (self.m_total_images == self.m_num_images) {
                    self.performSelector(onMainThread: #selector(ViewControllerGallery.CreateViews), with: nil, waitUntilDone: false)
                }
            }
        }
        
        task.resume()
        
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
