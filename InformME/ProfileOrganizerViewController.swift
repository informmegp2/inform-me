//
//  ProfileOrganizerViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/26/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class ProfileOrganizerViewController : CenterViewController , UITextFieldDelegate{
    /*Hello : ) */
    
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var bioField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var e :EventOrganizer = EventOrganizer()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        usernameField.delegate = self
        emailField.delegate = self
        bioField.delegate = self
        passwordField.delegate = self
        e.requestInfo(){
            (OrganizerInfo:EventOrganizer) in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.usernameField.text = OrganizerInfo.username
                self.emailField.text = OrganizerInfo.email
                self.bioField.text = OrganizerInfo.bio
            }
            
        }
        
        
        
        
    }// fun didload
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func save(sender: AnyObject) {
        let username = usernameField.text!
        let email = emailField.text!
        let  password = passwordField.text!
        let bio = bioField.text!
        
        var count: Int
        count = password.characters.count

        
        if (username.isEmpty || email.isEmpty || password.isEmpty) {
            
            displayAlert("", message: "يرجى إدخال كافة الحقول")
            
        }// end if chack
            
        else if ( count < 8)
        {
            displayAlert("", message: "يرجى إدخال كلمة مرور لا تقل عن ثمانية أحرف")
            
            
        }//end else if
        else if (isValidEmail(email) == false) {
            
            displayAlert("", message: "  يرجى إدخال صيغة بريد الكتروني صحيحة")
            
        }
    
        else {
            let alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
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
        
        
        
        
    }//end fun save
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    
    //for alert massge
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            if( message != "يرجى إدخال كافة الحقول") {
                self.dismissViewControllerAnimated(true, completion: nil) }
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert
    
    
    
    
    
    
    @IBOutlet var scrollView: UIScrollView!
    func textFieldDidBeginEditing(textField: UITextField) {
        scrollView.setContentOffset((CGPointMake(0, 150)), animated: true)
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset((CGPointMake(0, 0)), animated: true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    var window:UIWindow!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()
        if(segue.identifier == "backtohomepage"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController1") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
            
            containerViewController.centerViewController.delegate?.collapseSidePanels!()
            
        }
        
    }
    
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
}