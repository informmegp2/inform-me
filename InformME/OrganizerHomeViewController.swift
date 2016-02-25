//
//  OrganizerHomeViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

import UIKit

class OrganizerHomeViewController: UIViewController {
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tint color for tha back button.
    }
    
  
    
    @IBAction func outButton(sender: AnyObject) {
       
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        let session = NSUserDefaults.standardUserDefaults().stringForKey("session")!
        
        print(session)
        print(" iam in 2")

        var current: Authentication = Authentication();
        
        current.logout(session)
        
        /* var current: Authentication = Authentication();
        
        current.logout(){
        (login:Bool) in
        //we should perform all segues in the main thread
        dispatch_async(dispatch_get_main_queue()) {
        flag = login
        //   self.performSegue(flag,type: type)}
        if(flag) {
        self.performSegueWithIdentifier("backlogon", sender: self)
        print("I am happy",login,flag) }
        } */
        print("I am Here")
        
        // }
        
        

        
    
    } //end out */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}