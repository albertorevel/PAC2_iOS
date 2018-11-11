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
    
    var m_current_uIImageView:UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // BEGIN-CODE-UOC-4
        
        // We convert JSON into a Data type variable
        let m_data:Data = m_str_json.data(using: String.Encoding.utf8)!
        
        do {
            let list: NSMutableArray = try JSONSerialization.jsonObject(with: m_data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
            
            // Variables initialization
            self.m_total_images = list.count
            self.m_images = NSMutableArray(capacity: self.m_total_images)
            self.m_views = NSMutableArray(capacity: self.m_total_images)
            var urlString:String
            
            for img in list {
                urlString = img as! String
                OpenImage(str_url: urlString)
            }
            
            // Loader animation starts
            self.m_loader?.startAnimating()
            
        } catch {
            print("Unexpected error: \(error).")
        }

        // END-CODE-UOC-4

    }
    
    @objc func AnimateRec(_ timer:Timer)
    {
        
        // BEGIN-CODE-UOC-7
        
        // We retrieve image that will be shown
        let uIImageView:UIImageView = self.m_views?.object(at: self.m_next_index) as! UIImageView
        
        // We store image horizontal start point
        let originalOrigin = uIImageView.frame.origin
        uIImageView.frame.origin.x = self.view.frame.size.width
        
        self.view.addSubview(uIImageView)
        
        self.view.bringSubviewToFront(uIImageView)
        
        // We create a transition to display new image
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            uIImageView.frame.origin.x = originalOrigin.x
            
        }, completion: { finished in
            
            // When transition is done, whe increment next image index and we set a timer
            self.m_next_index = (self.m_next_index + 1) % self.m_total_images
            
            self.m_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self
                , selector: #selector(self.AnimateRec), userInfo: nil, repeats: false)
        })
        
        
        
       
        // END-CODE-UOC-7
        
    }
    
    
    @objc func CreateViews()
    {
        // BEGIN-CODE-UOC-6
        // We create UIImageViews that whill contain loaded images
        self.view.contentMode = UIView.ContentMode.center
        for image in self.m_images! {
            
            // We crop the image
            if let imageCropped = cropImage(imageToCrop: image as? UIImage) {
                
                let imageView:UIImageView = UIImageView(image: imageCropped as UIImage)
                
                imageView.contentMode = UIView.ContentMode.center
                imageView.clipsToBounds = true
                
                self.view.backgroundColor = UIColor.black
                
                self.m_views?.add(imageView)
            }
        }
        
        // We show first image and we stop loader animation
        let uIImageView = self.m_views?.object(at: self.m_next_index) as! UIImageView

        self.view.addSubview(uIImageView)
        self.view.bringSubviewToFront(uIImageView)

        self.m_current_uIImageView = uIImageView

        self.m_next_index = 1
        self.m_loader?.stopAnimating()
        
        
        // We initialize a timer in order to change the image which is displaying
        self.m_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self
            , selector: #selector(AnimateRec), userInfo: nil, repeats: false)
         // END-CODE-UOC-6
    
    }
    
 
    
    
    func OpenImage(str_url:String)
    {
         // BEGIN-CODE-UOC-5
        
        // Image load from given url
        let url:URL = URL(string: str_url)!

        let request:URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        
        let session:URLSession = URLSession.shared
        
        // When there's a response, it creates a new UIImage with received data and increments loaded images counter
        let task:URLSessionDataTask = session.dataTask(with: request){
            (data, response, error) -> Void in
            
            if(data != nil && error == nil) {
                
                let image:UIImage = UIImage(data: data!)!
                
                self.m_images?.add(image)
                
                self.m_num_images += 1
                
                // When all images are loaded, we call the method who will create views
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
    
    
    // Function that crops an image depending on controller's view size (frame)
    func cropImage (imageToCrop : UIImage?) -> UIImage? {
        
       var imageCropped = imageToCrop
        
        var imageRect = self.view.frame
        
        // Horizontal crop if image's width is bigger tan frame's
        if let imageWidth = imageCropped?.cgImage?.width {
            let difference = (CGFloat(imageWidth) - imageRect.width) / 2
            if (difference > 0) {
                imageRect.origin.x = difference
            }
        }
        
        // Vertical crop if image's height is bigger than frame's
        if let imageHeight = imageCropped?.cgImage?.height {
            let difference = (CGFloat(imageHeight) - imageRect.height) / 2
            if (difference > 0) {
                imageRect.origin.y = difference
            }
        }
        
        // Image crop
        if let imageRef = imageCropped?.cgImage?.cropping(to: imageRect) {
            imageCropped = UIImage(cgImage: imageRef)
        }
        
        return imageCropped
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
