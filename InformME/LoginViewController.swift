//
//  ViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 1/28/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit
import Foundation


class LoginViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate{
/*Hello : ) */

    
    @IBOutlet var emailfiled: UITextField!
    @IBOutlet var passwordfiled: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet  var typefiled: UISegmentedControl!
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailfiled.delegate = self
        passwordfiled.delegate = self
    }// end fun viewDidLoad
    
    
    @IBAction func login(sender: AnyObject) {
        
        let email = emailfiled.text!
        let password = passwordfiled.text!
        var type: Int
        type = -1;
        
        if (typefiled.selectedSegmentIndex == 0 ){
            type = 0; }
            
        else if ( typefiled.selectedSegmentIndex == 1  ){    type = 1; }
        
        
        
        if (email.isEmpty || password.isEmpty || type == -1 ) {
              displayAlert("", message: "يرجى إدخال كافة الحقول")
        }
            
        else if (isValidEmail(email) == false) {
        
        displayAlert("", message: "  يرجى إدخال صيغة بريد الكتروني صحيحة")
        
        }
            
        else {
            
            var flag: Bool
            flag = false
            let current: Authentication = Authentication();
            if(Reachability.isConnectedToNetwork()){
            //Wher use a completion handler here in order to make sure we got the latest value of flag.
            current.login( email, Passoword: password, Type: type) {
                (login:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
                    flag = login
                    self.performSegue(flag,type: type)}
                print("I am happy",login,flag)
                        }
                print("I am Here")
        
            }
            else {
                self.displayAlert("", message: "الرجاء الاتصال بالانترنت")

            }
        }
    }// end fun login
  
    func performSegue(flag: Bool, type: Int) {
        print("Is it")
        if ( flag  && type == 1) {
            print("here1")

            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let containerViewController = ContainerViewController()
            containerViewController.centerViewController = UIStoryboard.centerViewController1()
            window!.rootViewController = containerViewController
            window!.makeKeyAndVisible()
            self.performSegueWithIdentifier("homepage", sender: self)
        }
            
        else if ( flag && type == 0) {
            print("here2")
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let containerViewController = ContainerViewController()
            containerViewController.centerViewController = UIStoryboard.centerViewController2()
            print(window!.rootViewController)

            window!.rootViewController = containerViewController
            print(window!.rootViewController)

            window!.makeKeyAndVisible()
            self.performSegueWithIdentifier("homepage2", sender: self)
            
        }
            
        else if ( !flag ) {
            print("here3")

            self.displayAlert("", message: " البريد الإلكتروني أو كلمة المرور غير صحيحة")
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
   
    }//end fun didReciveMemory warining

    
    func isValidEmail(testStr:String) -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    
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
    //for alert massge

    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert

}//end class
