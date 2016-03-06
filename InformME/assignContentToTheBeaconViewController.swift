//
//  assignContentToTheBeaconViewController.swift
//  InformME
//
//  Created by nouf abdullah on 5/26/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class assignContentToTheBeaconViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    var beaconsInfo:NSMutableArray=[]

    @IBOutlet var tableview: UITableView!
    var uid=13
    var cid=159
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        tableview.reloadData()
          // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func assign(sender: AnyObject) {
        
        
        var alertController = UIAlertController(title: "", message: "هل تود ربط المحتوى بهذا البيكون", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            var b: Beacon = Beacon()
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! BeaconTableCellViewController
            
            let indexPath = self.tableview.indexPathForCell(cell)
            b = self.beaconsInfo[(indexPath?.row)!] as! Beacon
            
            
            b.assign(b.Label, cid: self.cid){
                (done:Bool) in
                dispatch_async(dispatch_get_main_queue()) {
                }}

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
    
    func get(){
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/beacon/SelectBeacon.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "uid=\(self.uid)"
        
        
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
                        self.beaconsInfo.addObject(beacon)
                        
                        
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.tableview.reloadData()}
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        task.resume()
        tableview.reloadData()

    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("beaconCell", forIndexPath: indexPath) as! BeaconTableCellViewController
        //var maindata = values[indexPath.row].minor
        var b: Beacon = Beacon()
        b = self.beaconsInfo[indexPath.row] as! Beacon
        
        cell.name.text = b.Label+" \n القيمة الأساسية:"+b.Major+" ،القيمة الثانوية: "+b.Minor as? String
        
        
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return beaconsInfo.count;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
