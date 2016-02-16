//
//  ViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 1/28/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
/*Hello : ) */
    
    
    
    
    @IBOutlet weak var emailfiled: UITextField!
    @IBOutlet weak var passwordfiled: UITextField!
    
    @IBOutlet weak var typefiled: UISegmentedControl!
    
    @IBAction func login(sender: AnyObject) {
        
        var email = emailfiled.text!
        var password = passwordfiled.text!
        var type: Int
        type = -1;
        switch typefiled.selectedSegmentIndex
        {
        case 0:
            type = 0;
        case 1:
            type = 1;
        
        default:
            break;
        }// end switch
        
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
        
        // Do any additional setup after loading the view, typically from a nib.
      /*  Alamofire.request(.GET, "http://bemyeyes.co/Service.php")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

