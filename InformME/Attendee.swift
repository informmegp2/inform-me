//
//  Attendee.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
class Attendee {
    var username:String = ""
    var password:String = ""
    var email:String = ""
    
    func createAccount(username: String, email: String,password: String, completionHandler: (login:Bool) -> ()) {
        
         struct f { static var flag = false }
        
        var Type: Int
        Type = 0
        
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
            
            else{
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    let l = jsonResult["status"]!!
                    
                    let s = String (l)
                    print (s+"hi")

                  if( s == "success") {
                        f.flag = true
                    print (s+"hi 1111")
                    
                    } //end if
                  else if( s == "unsuccess") {
                    f.flag = false
                    print (s+"hi 222")
                    
                    } //end else
                    
                    
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            }//end else
            
            
            // You can print out response object
           // print("response = \(response)")
            
            
            //completion handler values.
            completionHandler(login: f.flag)
            
            
        }
        
        task.resume()
        
        
        
    } // end fun creat account
    
    
    // no need dublicted method func fillUserInfo(username: String, email: String,password: String) {}
}
