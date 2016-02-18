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
                    
                    print(jsonResult)
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }

            
            
            // You can print out response object
           print("response = \(response)")
            
            
            
            
        }
        
        task.resume()

    
    
    } // end fun login
    
    
    func logout(){}
    
    func forgetPassword(){}
    func requestPassword(email: String){}
    func recoverPassword(password: String){}
    }