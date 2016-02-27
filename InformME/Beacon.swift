//
//  Beacon.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class Beacon {
    var Label:  String = ""
    var Major: String = ""
    var Minor: String = ""
    
      func addBeacon(label: String,major: String,minor: String,completionHandler: (flag:Bool) -> ()) {
        
        var f=false

        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/AddBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        
        let postString = "Label="+label+"&Major="+major+"&Minor="+minor+"&UserID=1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            f=true

            // You can print out response object
            print("response = \(response)")
            
            completionHandler(flag: f)

            
        }
        
        task.resume()
}
    func fillForm(label: String,major: String,minor: String) {}
    
    func updateBeacon(label: String,major: String,minor: String , Temp: String ,completionHandler: (flag:Bool) -> ()) {
        
        var f=false

        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/EditBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        
        let postString = "Label="+label+"&Major="+major+"&Minor="+minor+"&PreLabel="+Temp
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            f=true

            // You can print out response object
            print("response = \(response)")
            
            completionHandler(flag: f)

            
        }
        
        task.resume()
        
        
    }

    func updateform(label: String, major: String, minor: String) {}
    func displayBeacon() {}
    
    func deleteBeacon(label: String) {
        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/DeleteBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
      
        let postString = "Label="+label
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
   
    func MonitorBeacon() -> CLBeaconRegion {
        //When the app starts the application will begin scanning for beacons
        //This ID is temporary, I will create a UUID for all of our beacons
        
        let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "MyBeacon")
     /*   beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyEntryStateOnDisplay = true
        */
        
return beaconRegion

    
    }
    
    
    func BeaconNotification(){
        
    let notification = UILocalNotification()
    notification.alertBody =
    "Hello!"
    UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    
    
}

