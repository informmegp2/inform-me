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
    func login(email: String, Passoword: String, Type: Int) -> Bool{
    
        struct f { static var flag = false }

    
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
            else {
                
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    let l = jsonResult["account"]!!["status"]
                    let s = String (l)
                    
                    print (s)
                   if( s == "true") {
                    let id = jsonResult["account"]!!["ID"]
                    let email = jsonResult["account"]!!["email"]
                    let type = jsonResult["account"]!!["type"]
                    let session = jsonResult["account"]!!["session"]

                    print(id, email, type, session)

                    
        NSUserDefaults.standardUserDefaults().setObject(id, forKey: "id")
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: "email")
        NSUserDefaults.standardUserDefaults().setObject(type, forKey: "type")
     NSUserDefaults.standardUserDefaults().setObject(session, forKey: "session")
                 NSUserDefaults.standardUserDefaults().synchronize()

                  /* for jawaher to check
                    print(id, email, type, session)
                    print("lol")  
*/
                    f.flag = true
                    
                }//end if
                    
                    else if( s == "false") {
                        f.flag = false
                    print (s)

                        
                    } //end else
                    
                    
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
                } }

            
            
            // You can print out response object
         //  print("response = \(response)")
            
            
            
            
        }
        
        task.resume()
        
     /*
        
        
        var cID = ""
        var cemail = ""
        var ctype = ""
        var csession = ""
        
        let current = NSUserDefaults.standardUserDefaults()
         cID = current.stringForKey("id")!
         cemail = current.stringForKey("email")!
         ctype = current.stringForKey("type")!
         csession = current.stringForKey("session")!
        
         print(cID)
        print(cemail)
        print(ctype)
        print(ctype)

        if (!cID.isEmpty && !cemail.isEmpty && !ctype.isEmpty && !csession.isEmpty) {
        
            flag.self = true } */
        

       /* for jawaher to check its save the in defaults  let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("id")
        {
            print("reading")
            print(name)
        }
    */
        
    return f.flag } // end fun login
    
    
    func logout(){}
    
    func forgetPassword(){}
    func requestPassword(email: String){}
    func recoverPassword(password: String){}
    }