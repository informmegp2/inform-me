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
    var event: Event?
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
  
    
    
    
    @IBAction func out(sender: AnyObject) {
    
        
        
        
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        let current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    
                    self.performSegueWithIdentifier("backtologin", sender: self)
                    
                    
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
        
        
        
        
        
    } //end out */

        
    // MARK: -Segue Functions
    @IBAction func reportButton() {
        self.performSegueWithIdentifier("showReport", sender: self)

    }
    
    @IBAction func detailsButton(){
        self.performSegueWithIdentifier("showContents", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showReport") {
            let reportVC = segue.destinationViewController as! ReportViewController;
            reportVC.event = self.event!
        }
        else     if (segue.identifier == "showContents") {
            let contentVC = segue.destinationViewController as! ManageContentsViewController
            contentVC.EID =  self.evid

        }
        else    if (segue.identifier == "updateEvent") {
          
          
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let detailVC = segue.destinationViewController as! UpdateEventViewController;
            detailVC.evid = evid
            detailVC.evname=evname
            detailVC.evwebsite=evwebsite
            detailVC.evdate=evdate
            
            detailVC.evlogo=evlogo
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
