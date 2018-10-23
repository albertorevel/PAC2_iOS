//
//  ViewController.swift
//  PR1S
//
//  Created by Javier Salvador Calvo on 24/9/16.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var m_provider:CItemProvider? = nil;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.m_provider = CItemProvider()
        self.m_provider?.m_delegate = self

        
        let view: UITableView = (self.view as? UITableView)!;
        view.delegate = self
        view.dataSource = self
        view.tableFooterView = UIView(frame: CGRect.zero)


        
        
       
        let refreshControl : UIRefreshControl = UIRefreshControl()
        
        self.refreshControl = refreshControl
        
    
        refreshControl.backgroundColor = UIColor.gray
        
        refreshControl.tintColor = UIColor.white
        
        refreshControl.addTarget(self, action: #selector(Reload), for: UIControl.Event.valueChanged)
        
        view.addSubview(refreshControl)
        
        
    }
    
    @objc func Reload()
    {

        self.m_provider?.LoadAndParse();
        let view: UITableView = (self.view as? UITableView)!
        view.reloadData()
    }
    
    func LoadingEnd()
    {
        self.refreshControl?.endRefreshing()
        let view: UITableView = (self.view as? UITableView)!
        view.reloadData()
        
    
    
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let view: UITableView = (self.view as? UITableView)!
        if (!((self.m_provider?.m_loading)!)) {
        
            var fy:CGFloat = -1.0 * (self.refreshControl?.frame.size.height)!;
        
            view.setContentOffset(CGPoint(x:0,y:fy), animated: true)
        
        
            self.refreshControl?.beginRefreshing();
        
            self.m_provider?.LoadAndParse()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //*********************************************************************
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int = 0
        if (self.m_provider?.m_loading)! {
            count = (self.m_provider?.GetCount())!
        }
        return count
        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let item: CItemData = self.m_provider!.GetItemAt(position: indexPath.row)
        
        // BEGIN-CODE-UOC-1
         var vc:UIViewController
      
        // Load a different ViewController depending on item type
        switch item.m_type {
        case 4:
            vc = ViewControllerGallery(nibName: "ViewControllerGallery", bundle: nil)
            (vc as! ViewControllerGallery).m_str_json = item.m_data
            break
        case 7:
            // If type is equal to 7, we open a ViewControllerDraw to show data as a graphic
            vc = ViewControllerDraw(nibName: "ViewControllerDraw", bundle: nil)
            (vc as! ViewControllerDraw).m_str_json = item.m_data
            break
        default:
            // Otherwise, we open basic view
            vc = ViewControllerBasic(nibName: "ViewControllerBasic", bundle: nil)
            (vc as! ViewControllerBasic).m_item = item
        }
        
        let p: UINavigationController = (self.parent as? UINavigationController)!
        p.pushViewController(vc, animated: true)
          // END-CODE-UOC-1
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            return 200
        } else {
            return 150
            
        }

        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.m_provider?.m_loading)! {
            let wt: CGFloat = self.view.bounds.size.width
            let item: CItemData = self.m_provider!.GetItemAt(position: indexPath.row)
            var cell: UITableViewCell
            cell = UITableViewCell()
            cell.selectionStyle = .none;
           
            
            let imageIcon: UIImageView = UIImageView(image: UIImage(named:"icons/icon\(item.m_type).png"))
            imageIcon.frame = CGRect(x:10, y:10, width:50, height:50)
            cell.contentView.addSubview(imageIcon)
            
            // *************************
            
            var topLabel: UILabel
            if (UIDevice.current.userInterfaceIdiom == .pad) {
                //topLabel = UILabel(frame:(10+50+10, 10, wt-(10+50+10+10), 180))
                
                topLabel = UILabel(frame: CGRect(x:10+50+10,y:10,width:wt-(10+50+10+10),height:180));
                
                let fuente: UIFont = UIFont(name: "Georgia-Bold", size: 34)!
                topLabel.font = fuente
            } else {
                topLabel = UILabel(frame: CGRect(x:10+50+10, y:10, width:wt-(10+50+10+10), height:130))
                let fuente: UIFont = UIFont(name: "Georgia", size: 24)!
                topLabel.font = fuente
                
            }
            topLabel.numberOfLines = 4
            topLabel.text = item.m_title
            topLabel.sizeToFit()
            cell.contentView.addSubview(topLabel)
            return cell
        } else {
            var cell: UITableViewCell
            cell = UITableViewCell()
            cell.selectionStyle = .none;

            return cell
        }
    }
    
   
    
    // *******************************************
    

}

