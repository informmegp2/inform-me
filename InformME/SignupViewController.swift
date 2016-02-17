//
//  SignupViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/2/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    /*Hello : ) */
    
    
    @IBOutlet  var regType: UISegmentedControl!
    @IBOutlet  var regUsername: UITextField!
    @IBOutlet  var regEmail: UITextField!
    @IBOutlet  var regPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regUsername.delegate = self
        regEmail.delegate = self
        regPassword.delegate = self

        //setup tint color for tha back button.
       
    }// end fun viewDidLoad
    
    
    
    
    @IBAction func register(sender: AnyObject) {
        
        var username = regUsername.text!
        var email = regEmail.text!
        var password = regPassword.text!
        var type: Int
        type = -1;
        
        if (regType.selectedSegmentIndex == 0 ){
            type = 0; }
            
        else if ( regType.selectedSegmentIndex == 1  ){    type = 1; }
        
         if (username.isEmpty || email.isEmpty || password.isEmpty || type == -1 ) {
            
          displayAlert("", message: "يرجى إدخال كافة الحقول")

         }// end if chack
        
         else {
            // call to create register
        
        } //end else
        
        
    }// end fun register
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
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