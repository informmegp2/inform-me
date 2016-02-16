//
//  ViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 1/28/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
/*Hello : ) */
    
    
    
    
    @IBOutlet var emailfiled: UITextField!
    @IBOutlet var passwordfiled: UITextField!
    
    
    @IBOutlet  var typefiled: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailfiled.delegate = self
        passwordfiled.delegate = self
        // Do any additional setup after loading the view.
        
    }// end fun viewDidLoad
    
    
    @IBAction func login(sender: AnyObject) {
        
        var email = emailfiled.text!
        var password = passwordfiled.text!
        var type: Int
        type = -1;
        
        if (typefiled.selectedSegmentIndex == 0 ){
            type = 0; }
            
        else if ( typefiled.selectedSegmentIndex == 1  ){    type = 1; }
        
        
        
        if (email.isEmpty || password.isEmpty || type == -1 ) {
            
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            var current: Authentication = Authentication();
            
    
            current.login( email, Passoword: password, Type: type)

                    }

    }// end fun login
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
   
    }//end fun didReciveMemory warining

    
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
