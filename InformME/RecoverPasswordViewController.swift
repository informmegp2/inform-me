//
//  RecoverPasswordViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class RecoverPasswordViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet var recType: UISegmentedControl!
    
    @IBOutlet var recEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recEmail.delegate = self
        // Do any additional setup after loading the view.
        
    }// end fun viewDidLoad
    
    
    
    
    
    @IBAction func recover(sender: AnyObject) {
  
    
        let email = recEmail.text!
        var type: Int
        type = -1;
        
        if (recType.selectedSegmentIndex == 0 ){
            type = 0; }
            
        else if ( recType.selectedSegmentIndex == 1  ){    type = 1; }
        
        
        
        if (email.isEmpty || type == -1 ) {
            displayAlert("", message: "يرجى إدخال كافة الحقول")
        } // end if
            
        else {
            // call to recover
            var flag: Bool
            flag = false
            
             let current: Authentication = Authentication();
            if(Reachability.isConnectedToNetwork()){
            current.recoverPassword(email , Type: type){
                (login:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
                    flag = login
                    if(flag) {
                        self.displayAlert("", message: " تم إرسال البريد الإلكتروني")
                        
                    print("I am happy",login,flag)
                    }//end if
                    
                    
                    
          
             
                    else if(!flag){
            print("I am Here")
            self.displayAlert("", message: "  البريد الإلكتروني المدخل غير مسجل لدينا")
                    }//en else if
                    
         }// dispatch
        
            }//end call
            }//Network Check
            else {
                self.displayAlert("", message: "الرجاء الاتصال بالانترنت")
            }
    
            
        } //end else
        
        

    }// end fun recover
    
        
        
   
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }//end fun didReciveMemory warining
    
    
    
    //for alert massge
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            if(message == " تم إرسال البريد الإلكتروني")
            {
                print("Oooops")
                self.performSegueWithIdentifier("backtologin", sender: self)

            }
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert 
    
    
    
    // *** for keyboard
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
    // *** for keyboard

    
    
} // end class