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
    
      func addBeacon(label: String,major: String,minor: String) {
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
            
            // You can print out response object
            print("response = \(response)")
            
            
            
        }
        
        task.resume()
}
    func fillForm(label: String,major: String,minor: String) {}
    
    func updateBeacon(label: String,major: String,minor: String , Temp: String) {
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
            
            // You can print out response object
            print("response = \(response)")
            
            
            
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
    func MonitorBeacon(beaconManager:ESTBeaconManager) {
        //When the app starts the application will begin scanning for beacons
        //**********************This ID is temporary, I will change it later to include all beacons ************************
        
       beaconManager.startMonitoringForRegion(CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
            major:7645,minor: 4136, identifier: "Region"))
        
        //To be notified upon entering and exiting region
       /* beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        
        beaconManager.startRangingBeaconsInRegion(beaconRegion)
        beaconManager.startMonitoringForREgion(beaconRegion)*/
        
    
    }
    
    //For testing .. Delete before publishing
   
    
    
    func BeaconNotification(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "There are beacons nearbly!"//** Will change to Arabic whenever I can think of something decent to say
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
}

