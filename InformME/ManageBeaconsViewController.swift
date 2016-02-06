//
//  ManageBeaconsViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

import UIKit

class ManageBeaconsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tint color for tha back button.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    // TODO: Check the dynamic table tutorial in Google Drive it will help a lot.
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("beaconCell", forIndexPath: indexPath) as! BeaconTableCellViewController
        
        // if self.retrievedEvents != nil && self.retrievedEvents?.count >= indexPath.row
        //{
        //let beacon = self.beacons![indexPath.row]
        cell.delegate = self
        //cell.label.text = beacon.laber
        //cell.major.text = beacon.major
        //cell.minor.text = beacon.minor
        // }
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return 10;
    }

}