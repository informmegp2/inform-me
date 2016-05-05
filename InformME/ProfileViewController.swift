//
//  ProfileViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//backtohoempage

import Foundation
import UIKit

class ProfileViewController: CenterViewController , UITextFieldDelegate{
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var usernameFiled: UITextField!
    @IBOutlet var emailFiled: UITextField!
    @IBOutlet var bioFiled: UITextField!
    @IBOutlet var passwordFiled: UITextField!
    var e: Attendee = Attendee()
    
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameFiled.delegate = self
        emailFiled.delegate = self
        bioFiled.delegate = self
        passwordFiled.delegate = self
        e.requestInfo(){
            (AttendeeInfo:Attendee) in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.usernameFiled.text = AttendeeInfo.username
                self.emailFiled.text = AttendeeInfo.email
                self.bioFiled.text = AttendeeInfo.bio
            }
        }
        
        
    }//end fun didload
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    
    @IBAction func save(sender: AnyObject) {
        let username = usernameFiled.text!
        let email = emailFiled.text!
        let  password = passwordFiled.text!
        let bio = bioFiled.text!
        
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    // *** for keyboard
    
    var window:UIWindow!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()
        if(segue.identifier == "backtohoempage"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController2") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()

            containerViewController.centerViewController.delegate?.collapseSidePanels!()
            
        }
        
    }
    
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
}
