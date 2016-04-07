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
    var save : Bool = false;
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");

      func addBeacon(label: String,major: String,minor: String,completionHandler: (flag:Bool) -> ()) {
        
        var f=false

        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/AddBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        let majorHash = "\(UserID),\(major)"
        let minorHash = "\(UserID),\(minor)"
        let postString = "Label="+label+"&Major="+majorHash+"&Minor="+minorHash+"&UserID=\(UserID)"
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
    
    func assign (label: String, var cid:Int ,completionHandler: (flag:Bool) -> ()) {
        var f=false
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/assign.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
       var cid1=String(cid)
        let postString = "label="+label+"&cid="+cid1
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
    
    func requestbeaconlist(id: Int,completionHandler: (beaconsInfo:[Beacon]) -> ()){
        var beaconsInfo: [Beacon] = []
        print("in beacon managment")
        let uid=id
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/beacon/SelectBeacon.php")!)
        request.HTTPMethod = "POST"
        let postString = "uid=\(uid)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    for var x=0; x<jsonResult.count;x++ {
                        
                        
                        var beacon: Beacon = Beacon()
                        var l : AnyObject = jsonResult[x]["Label"]as! String
                        var m : AnyObject = jsonResult[x]["Major"]as! String
                        var mi : AnyObject = jsonResult[x]["Minor"]as! String
                        
                        beacon.Label=l as! String
                        let majorsplits = (m as! String).characters.split{$0 == ","}.map(String.init)
                        
                        let minorsplits = (mi as! String).characters.split{$0 == ","}.map(String.init)
                        
                        beacon.Major=majorsplits[1]
                        beacon.Minor=minorsplits[1]
                        beaconsInfo.append(beacon)
                        
                        
                        
                    }
                    
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            print("here?")
            completionHandler(beaconsInfo: beaconsInfo)
        }
        task.resume()
        print("hi");
    }
    

    func fillForm(label: String,major: String,minor: String) {}
    

         func updateBeacon(label: String,major: String,minor: String , Temp: String){
        
        save = false;
        var f=false

        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/EditBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
            let majorHash = "\(UserID),\(major)"
            let minorHash = "\(UserID),\(minor)"
        
        let postString = "Label="+label+"&Major="+majorHash+"&Minor="+minorHash+"&PreLabel="+Temp
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
           // completionHandler(flag: f)
//
            
        }
            save = true
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
    "هنالك بيكون بالقرب منك!"
    UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    
    
}

