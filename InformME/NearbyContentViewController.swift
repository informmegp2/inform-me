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
    
    
    @IBOutlet var tableView: UITableView!
    
    var Requested: [String] = [""]
    var contentList = [Content]()
    var uid = 30;

    
    //This manager is for ranging
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "MyBeacon")
    
    //Here we will search for content nearby
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()
    }
   
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
     func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
       return contentList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath)
    as! ContentTableCellViewController
    
        cell.Title.text = contentList[indexPath.row].Title
   
        cell.tag = contentList[indexPath.row].contentId
        
        cell.ViewContentButton.tag = contentList[indexPath.row].contentId
        
        cell.SaveButton.tag = contentList[indexPath.row].contentId
        
        return cell
        
    }

    @IBAction func save(sender: UIButton) {
        
        let image = UIImage(named: "starF.png") as UIImage!
        sender.setImage(image, forState: .Normal)
        
        Content ().saveContent(uid, cid: (sender.tag))
        
        
      
    }
   
 
    
    override func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?)
    {        print("in segue")

        if (segue.identifier == "ShowView")
    {
        var upcoming: ContentForAttendeeViewController = segue.destinationViewController as! ContentForAttendeeViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        
           let cid = contentList[indexPath.row].contentId
        
            upcoming.cid = cid
       
        }}
    
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
                   if let jsonResults = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [AnyObject]{
                    for item in jsonResults {
                        self.contentList.append(Content(json: item as! [String : AnyObject]))
                        }
                    }

                }
                catch {
                    // failure
                    print("Fetch failed: \((error as NSError).localizedDescription)")
                }
                
            }
            
        }
        task.resume()
        
    }
    

    
    
    //This method will be called everytime we are in the range of beacons
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
        inRegion region: CLBeaconRegion) {
            //Get the array of beacons in range
            if let beacons = beacons as? [CLBeacon] {
                //For each beacon in array
                for beacon in beacons {
                    //Check if the content was requested
                    if (!Requested.contains("\(beacon.major):\(beacon.minor)"))
                    {//If not request content then add to requested array
                        PHPget(beacon.major, minor: beacon.minor)
                        Requested.append("\(beacon.major):\(beacon.minor)")
                    }

                }
            }
             self.tableView.reloadData()
            
    }
    
    
    
}