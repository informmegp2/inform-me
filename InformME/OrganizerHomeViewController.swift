//
//  OrganizerHomeViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

import UIKit

class OrganizerHomeViewController: UIViewController  {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //setup tint color for tha back button.
    }
    
  
    
    @IBAction func outButton(sender: AnyObject) {
       
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}