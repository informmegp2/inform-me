//
//  ManageBeaconsViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

import UIKit

class ManageBeaconsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, BeaconCellDelegate  {
    
    
    var values:NSMutableArray = []
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        get();
        tableView.reloadData()
        //setup tint color for tha back button.
    }
    func get(){
        let uid=1
        
        
        
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
                        beacon.Major=m as! String
                        beacon.Minor=mi as! String
                        print (beacon.Label)
                        self.values.addObject(beacon)
                        
                        
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.tableView.reloadData()}
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        task.resume()
        print("hi");
        
        
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Check the dynamic table tutorial in Google Drive it will help a lot.
    // MARK: --- Table Functions ---
    
    /*   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("beaconCell", forIndexPath: indexPath) as! BeaconTableCellViewController
    
    // if self.retrievedEvents != nil && self.retrievedEvents?.count >= indexPath.row
    //{
    //let beacon = self.beacons![indexPath.row]
    cell.delegate = self
    //cell.label.text = beacon.laber
    //cell.major.text = beacon.major
    //cell.minor.text = beacon.minor
    // }
    return cell
    
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("beaconCell", forIndexPath: indexPath) as! BeaconTableCellViewController
        //var maindata = values[indexPath.row].minor
        var b: Beacon = Beacon()
        b = self.values[indexPath.row] as! Beacon
        
        cell.name.text = b.Label+" \n القيمة الأساسية:"+b.Major+" ،القيمة الثانوية: "+b.Minor as? String
        
        
        
        return cell
        
        
    }
    // Delete beacon
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
           /* var alertToDelete: UIAlertView = UIAlertView(title: "", message:  " هل أنت متأكد من الحذف " , delegate: <#T##UIAlertViewDelegate?#>, cancelButtonTitle: "نعم", otherButtonTitles: "لا")
            alertToDelete.show()*/
            
            var alertController = UIAlertController(title: "", message: "هل أنت متأكد من الحذف", preferredStyle: .Alert)
            
            // Create the actions
            var okAction = UIAlertAction(title: "نعم", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                var b: Beacon = Beacon()
                b = self.values[indexPath.row] as! Beacon
                self.values.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                self.deleteBeacon(b.Label)
            }
            var cancelAction = UIAlertAction(title: "لا", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
           
            
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return values.count;
    }
    
    
    
    
    func deleteBeacon(label: String) {
        var b: Beacon = Beacon()
        b.deleteBeacon(label)
    }
    
    /*  func updateBeacon() {
    //   code
    }*/
    
}