//
//  ProfileOrganizerViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/26/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class ProfileOrganizerViewController : UIViewController , UITextFieldDelegate{
    /*Hello : ) */
    
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var bioField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var e :EventOrganizer = EventOrganizer()
    
    
    
    override func viewDidLoad() {
        
        e.requestInfo(){
            (OrganizerInfo:EventOrganizer) in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.usernameField.text = OrganizerInfo.username
                self.emailField.text = OrganizerInfo.email
                self.bioField.text = OrganizerInfo.bio
                self.passwordField.text = OrganizerInfo.password
            }
            
        }
        
        
        
        
    }// fun didload
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        
        
        
        
    } //end fun out
    
    
    
    @IBAction func save(sender: AnyObject) {
        
        let username = usernameField.text!
        let email = emailField.text!
        let  password = passwordField.text!
        let bio = bioField.text!
        
        if (usernameField.text == "" || emailField.text == "" || passwordField.text == "") {
           self.displayAlert("", message: "يرجى إدخال كافة الحقول")
        }
    
        else {
            var alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
            
            // Create the actions
            var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
                let e : EventOrganizer = EventOrganizer()
                
                e.UpdateProfile ( username, email: email, password: password, bio: bio){
                    (flag:Bool) in
                    
                    if(flag) {
                    //we should perform all segues in the main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        print("Heeeeello")
                        self.performSegueWithIdentifier("backtohomepage", sender:sender)
                    }}
                
                }
                
                
            }
            
            var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel)
                {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
            }
            //Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        
    }//end fun save
    
    
    
    
    
    //for alert massge
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert
    
    
    
    
    
    
    // *** for keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    // *** for keyboard
    

    
}//end class