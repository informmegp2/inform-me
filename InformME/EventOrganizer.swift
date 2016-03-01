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
    var bio:String = ""
    func createAccount(username: String, email: String,password: String, completionHandler: (login:Bool) -> ()) {
        
        struct f { static var flag = false }
        
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
        
 
    
    func requestInfo(completionHandler: (OrganizerInfo:EventOrganizer) -> ()){
        
        
     
        let id=NSUserDefaults.standardUserDefaults().stringForKey("id")!
       
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/organizer/OrganizerInfo.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "UserID=\(id)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    
                    for var x=0; x<jsonResult.count;x++ {
                        var info: EventOrganizer = EventOrganizer()
                        var t : AnyObject = jsonResult[x]["UserName"]as! String
                        var a : AnyObject = jsonResult[x]["Email"]as! String
                        var p : AnyObject = jsonResult[x]["Password"]as! String
                        var v : AnyObject = jsonResult[x]["Bio"]as! String
                       
                        
                        
                        info.username=t as! String
                        info.email=a as! String
                        info.password=p as! String
                        info.bio=v as! String
                        
                      
                        completionHandler(OrganizerInfo: info)
                        
                        }}
                catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
        }
        task.resume()
        
        
    }
    
    
    
    
    func UpdateProfile(username: String,email: String,password: String,bio: String ,completionHandler: (flag:Bool) -> ()) {
        let id =
        NSUserDefaults.standardUserDefaults().stringForKey("id")!
        print(id + username + email + bio + password)
        struct f { static var flag = false }
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/organizer/EditProfileOrganizer.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        let postString = "UserID=\(id)&username=\(username)&email=\(email)&pass=\(password)&bio=\(bio)";
        
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
                        print (s+"hi this status update")
                        
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
            
            
         
            
            completionHandler(flag: f.flag)
            
            
            
        }
        task.resume()
        
    }
    
    
    
    
   // no need dublicted method func fillUserInfo(username: String, email: String,password: String) {}
}