//
//  Authentication.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//


import UIKit
import Foundation
class Authentication {
    func login(email: String, Passoword: String, Type: Int){
    
    
        let MYURL = NSURL(string:"http://bemyeyes.co/API/login.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        let postString = "email=\(email)&password=\(Passoword)&type=\(Type)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            
         //   var err: NSError?
         //   var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as NSDictionary
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    let id = jsonResult["account"]!!["ID"]
                    let email = jsonResult["account"]!!["email"]
                    let type = jsonResult["account"]!!["type"]
                    let session = jsonResult["account"]!!["session"]

                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    defaults.setObject(id, forKey: "id")
                    defaults.setObject(email, forKey: "email")
                    defaults.setObject(type, forKey: "type")
                    defaults.setObject(session, forKey: "session")

                   /* for jawaher just to check print(id, email, type, session)
                    print("lol") */
                    
                  //  self.performSegueWithIdentifier("showSigninScreen", sender: self)

                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }

            
            
            // You can print out response object
         //  print("response = \(response)")
            
            
            
            
        }
        
        task.resume()

       /* for jawaher to check its save the in defaults  let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("id")
        {
            print("reading")
            print(name)
        }
    */
        
    } // end fun login
    
    
    func logout(){}
    
    func forgetPassword(){}
    func requestPassword(email: String){}
    func recoverPassword(password: String){}
    }