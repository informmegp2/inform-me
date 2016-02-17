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
  
    
        var email = recEmail.text!
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
            
        } //end else
        
        

    }// end fun recover
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }//end fun didReciveMemory warining
    
    
    
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

    
    
} // end class