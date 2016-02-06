//
//  Beacon.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
class Beacon {
    var Label:  String = ""
    var Major: Int?
    var Minor: Int?
    
    func addBeacon(label: String,major: Int,minor: Int) {
        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/AddBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        //Change UserID"
        
        let postString = "Label="+Label+"&Major=+ \(Major)&Minor=+ \(Minor)&UserID=1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            
            
        }
        
        task.resume()
}
    func fillForm(label: String,major: String,minor: String) {}
    func updateBeacon() {}
    func updateform(label: String, major: String, minor: String) {}
    func displayBeacon() {}
    func deleteBeacon(label: String) {}
    func MonitorBeacon() {}
    func BeaconNotification() {}
}

