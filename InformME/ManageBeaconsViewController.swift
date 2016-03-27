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
    var Labels : [String] = []
    var beaconsInfo:NSMutableArray=[]
    var bID:Int = 1;
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        get();
        tableView.reloadData()
        //setup tint color for tha back button.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    
    @IBAction func out(sender: AnyObject) {
    
    
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        var current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    
                    self.performSegueWithIdentifier("backtologin", sender: self)
                    
                    
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
        
        
        
        
        
    } //end out */
    
    
    
    
    
    func get(){
        let uid=13
        
        
        
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
                        self.values.addObject(beacon)
                        self.beaconsInfo.addObject(beacon)
                        self.Labels.append(l as! String)
                        
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.tableView.reloadData()}
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        task.resume()
        tableView.reloadData()
    }
    
    func addBeacon(){
        performSegueWithIdentifier("addBeacon", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
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
            
            
            var alertController = UIAlertController(title: "", message: "هل أنت متأكد من رغبتك بالحذف", preferredStyle: .Alert)
            
            // Create the actions
            var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                var b: Beacon = Beacon()
                b = self.values[indexPath.row] as! Beacon
                self.values.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                self.deleteBeacon(b.Label)
            }
            var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
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
    
    
    // Update Beacon
    func updateBeacon(){
        performSegueWithIdentifier("updateBeacon", sender: self)
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        if (segue.identifier == "updateBeacon") {
            let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
            let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
            print(cellIndexPath?.row)
            var b : Beacon = Beacon()
            b=beaconsInfo[(cellIndexPath?.row)!] as! Beacon
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            var detailVC = segue.destinationViewController as! UpdateBeaconViewController;
            //detailVC.evid = e.id
            detailVC.llabel=b.Label
            detailVC.mmajor=b.Major
            detailVC.mminor=b.Minor
        
    }
    
    if (segue.identifier == "addBeacon") {
        var detailVC = segue.destinationViewController as! AddBeaconViewController
        //detailVC.evid = e.id
        detailVC.labels = Labels

    }
    
    }
    
    func deleteBeacon(label: String) {
        var b: Beacon = Beacon()
        b.deleteBeacon(label)
    }
    
    /*  func updateBeacon() {
    //   code
    }*/
    
}