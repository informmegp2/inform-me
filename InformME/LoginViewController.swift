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

