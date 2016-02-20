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

    
    // Add the property holding the data.
    // TODO: replace "<major>:<minor>" strings to match your own beacons
    let placesByBeacons = [
        "11553:40394": [
            "Heavenly Sandwiches": 50, // read as: it's 50 meters from
            // "Heavenly Sandwiches" to the beacon with
            // major 6574 and minor 54631
            "Green & Green Salads": 150,
            "Mini Panini": 325
        ],
        "7645:4136": [
            "Heavenly Sandwiches": 250,
            "Green & Green Salads": 100,
            "Mini Panini": 20
        ],
        "59149:53427": [
            "Heavenly Sandwiches": 350,
            "Green & Green Salads": 500,
            "Mini Panini": 170
        ]
    ]

    
    //Retrieving data below
    func placesNearBeacon(beacon: CLBeacon) -> [String] {
        let beaconKey = "\(beacon.major):\(beacon.minor)"
        print("\(beacon.major):\(beacon.minor)")
        if let places = self.placesByBeacons[beaconKey] {
            let sortedPlaces = Array(places).sort { $0.1 < $1.1 }.map { $0.0 }
            return sortedPlaces
        }
        return []
    }
    
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
        inRegion region: CLBeaconRegion) {
            if let nearestBeacon = beacons.first {
                let places = placesNearBeacon(nearestBeacon)
                // TODO: update the UI here
                //print(places) // TODO: remove after implementing the UI
            }
            
    }
    
    
    
 /*   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    */
}