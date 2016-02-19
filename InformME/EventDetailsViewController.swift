//
//  EventDetailsViewController.swift
//  InformME
//
//  Created by nouf abdullah on 4/30/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
   
    var evid: Int=1;
    var evname: String=""
    var evwebsite: String=""
    var evdate: String=""
    var evlogo: UIImage?
    @IBOutlet var ddate: UILabel!
    @IBOutlet var wwebsite: UILabel!
    @IBOutlet var nnamd: UINavigationItem!
    
    @IBOutlet var logo: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.wwebsite.text = evwebsite
        self.ddate.text = evdate
        self.nnamd.title = evname
        self.logo.image=evlogo
        print("here \(evid)")
      
        // Do any additional setup after loading the view.
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    *//*
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "updateEvent") {
          
          
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            var detailVC = segue!.destinationViewController as! UpdateEventViewController;
            //detailVC.evid = e.id
            detailVC.evname=evname
            detailVC.evwebsite=evwebsite
            detailVC.evdate=evdate
            
            detailVC.evlogo=evlogo
        }
        
    }*/
    
}
