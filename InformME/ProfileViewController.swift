//
//  ProfileViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//backtohoempage

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var usernameFiled: UITextField!
    @IBOutlet var emailFiled: UITextField!
    @IBOutlet var bioFiled: UITextField!
    @IBOutlet var passwordFiled: UITextField!
    var e: Attendee = Attendee()
    
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        e.requestInfo(){
            (AttendeeInfo:Attendee) in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.usernameFiled.text = AttendeeInfo.username
                self.emailFiled.text = AttendeeInfo.email
                self.bioFiled.text = AttendeeInfo.bio
               
                
            }
        }
            if self.revealViewController() != nil {
                self.menuButton.target = self.revealViewController()
                self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            }
        
        
    }//end fun didload
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    
    
    
    @IBAction func save(sender: AnyObject) {
        
        let username = usernameFiled.text!
        let email = emailFiled.text!
        let  password = passwordFiled.text!
        let bio = bioFiled.text!
        
        if (usernameFiled.text == "" || emailFiled.text == "" || passwordFiled.text == "") {
            self.displayAlert("", message: "يرجى إدخال كافة الحقول")
        }
            
        else {
            let alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
                let e : Attendee = Attendee()
                
                e.UpdateProfile ( username, email: email, password: password, bio: bio){
                    (flag:Bool) in
                    
                    if(flag) {
                        //we should perform all segues in the main thread
                        dispatch_async(dispatch_get_main_queue()) {
                            print("Heeeeello")
                            self.performSegueWithIdentifier("backtohoempage", sender:sender)
                        }}
                    
                }
                
                
            }
            
            let cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel)
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
        
        
        
        
        
        
    }// end fun save
    
    
    
    
    
    
    
    
    
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
        
        
        
        
        
        
    } //end out
    
    
    
    
    
    //for alert massge
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            if( message != "يرجى إدخال كافة الحقول") {
                self.dismissViewControllerAnimated(true, completion: nil) }
            
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
    
    
    
    
    
    

}