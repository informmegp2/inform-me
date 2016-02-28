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
    func login(email: String, Passoword: String, Type: Int, completionHandler: (login:Bool) -> ()){
    
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
                    
                    print (s+"Hi")
                    
                   if( s == "Optional(true)") {
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
                    
                    else if( s == "Optional(false)") {
                        f.flag = false
                    print (s)
                        
                    } //end else
                    
                    
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
                }
                }

            
            
            // You can print out response object
         //  print("response = \(response)")
            
            //completion handler values.
            completionHandler(login: f.flag)
  
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
    */ } // end fun login
    
    
    func logout(  completionHandler: (login:Bool) -> ()){
        
      
        
       struct f { static var flag = false }
    
        let session = NSUserDefaults.standardUserDefaults().stringForKey("session")!
       
        print("from defult= "+session)
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/logout.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        
        
        
        
        let postString = "&sessionID=\(session)";
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
                        print (s+"hi this status")
                        
                        if( s == "success") {
                            
                            NSUserDefaults.standardUserDefaults().removeObjectForKey("id")
                            
                            NSUserDefaults.standardUserDefaults().removeObjectForKey("email")
                            
                            NSUserDefaults.standardUserDefaults().removeObjectForKey("type")
                            
                            NSUserDefaults.standardUserDefaults().removeObjectForKey("session")
                            
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
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
            }//end els
            
            
            
            // You can print out response object
          //  print("response = \(response)")
            
            completionHandler(login: f.flag)

            
            
        }
        
        task.resume()
    
    
    
    } // end log out
    
    func forgetPassword(){
    
    
    }
    func requestPassword(email: String){}
    
    func recoverPassword(email: String , Type: Int, completionHandler: (login:Bool) -> ()){
    
    
    
        
        
        struct f { static var flag = false }
        
      
        
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/rest.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        
        
        
        
        let postString = "&email=\(email)&type=\(Type)";
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
                        print (s+"hi this status")
                        
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
            }//end els
            
            
            
            // You can print out response object
            //  print("response = \(response)")
            
            completionHandler(login: f.flag)
            
            
            
        }
        
        task.resume()
        
        
        
    } // end recover password fun
    
    
    
    
    
    
    
    
    
    
    
    
    
    }//end class