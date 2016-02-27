//
//  ContentForAttendeeViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/22/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
import Social

class ContentForAttendeeViewController: UIViewController {
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func shareContent(sender: AnyObject) {
        
        
       let actionSheet = UIAlertController(title: "", message: "انشر المحتوى عبر", preferredStyle: UIAlertControllerStyle.ActionSheet)
       
       
        let tweetAction = UIAlertAction(title: "تويتر", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
         let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterComposeVC.setInitialText("test code")
                self.presentViewController(twitterComposeVC, animated: true, completion: nil)

                
            }
            else {
               self.showAlertMessage("يجب عليك أولًا تسجيل الدخول بتويتر")
            }
        }
    
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        
        actionSheet.addAction(tweetAction)
       
        actionSheet.addAction(dismissAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
    
    @IBAction func out(sender: AnyObject) {
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        var current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    
                    self.performSegueWithIdentifier("backtologin", sender: self)
                    
                    
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
        
        
        
        
        
    } //end out */ backtologin
    
}