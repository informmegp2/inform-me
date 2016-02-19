//
//  EventOrganizer.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
class EventOrganizer {
    var username:String = ""
    var password:String = ""
    var email:String = ""
    
    func createAccount(username: String, email: String,password: String) {
        
        var Type: Int
        Type = 1
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/register.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        let postString = "username=\(username)&email=\(email)&password=\(password)&type=\(Type)";
        
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
        
        
        
    } // end fun creat account
        
 
    
   // no need dublicted method func fillUserInfo(username: String, email: String,password: String) {}
}