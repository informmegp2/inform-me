//
//  NearbyContentViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class NearbyContentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource , ESTBeaconManagerDelegate {
    @IBOutlet
    var tableView: UITableView!

    var items: [String] = ["We", "Heart", "Swift"]
    
    var Requested: [String] = [""]
    
    //This manager is for ranging
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "MyBeacon")
    
    //Here we will search for content nearby
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "contentCell")
        
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()
    }
   
    
    //To start/stop ranging as the view controller appears/disappears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("contentCell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
 

    func PHPget (major: NSNumber, minor: NSNumber)
    {
       
        //Col::(ContentID, Title, Abstract, Sharecounter, Label, EventID)
        print("HERE IN PHPget \(major):\(minor)")
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/getContent.php")!)
        request.HTTPMethod = "POST";
        let postString = "major=\(major)&minor=\(minor)";

        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
     
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            print("HERE in task");
            if error != nil {
                print("error=\(error)")
                return
            }
            else {
                do {
                   let jsonResults = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                  print(jsonResults)
                } catch {
                    // failure
                    print("Fetch failed: \((error as NSError).localizedDescription)")
                }

            }
            
        }
        task.resume()
        
    }
    
        
        
       /* let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)as! NSMutableArray
                }
            }
        }*/
        
        /*  let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response =  (response)")
            
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            //Let’s convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
            
            if let parseJSON =myJSON {
                // Now we can access value of First Name by its key
                var MajorValue = parseJSON["major"] as? String
                println("firstNameValue:\(MajorValue)")
            }*/
            
    
    
    //Retrieving data below
    func placesNearBeacon(beacon: CLBeacon) -> [String] {
   //  let beaconKey = "\(beacon.major):\(beacon.minor)"
        print("\(beacon.major):\(beacon.minor)")
        PHPget(beacon.major, minor: beacon.minor)
        print("HERE After PHPget")
        // if let places = self.placesByBeacons[beaconKey] {
           /* let sortedPlaces = Array(places).sort { $0.1 < $1.1 }.map { $0.0 }
            return sortedPlaces
        }*/
        return []
    }
    
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
        inRegion region: CLBeaconRegion) {
            
            if let beacons = beacons as? [CLBeacon] {
                
                for beacon in beacons {
                    if (!Requested.contains("\(beacon.major):\(beacon.minor)"))
                    {PHPget(beacon.major, minor: beacon.minor)
                        Requested.append("\(beacon.major):\(beacon.minor)")
                    }

                }
            }
            
            
            /*if let nearestBeacon = beacons.first {
              let places = placesNearBeacon(nearestBeacon)*/
                // TODO: update the UI here
                //print(places) // TODO: remove after implementing the UI
    }
    
    
    
}