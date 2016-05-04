//
//  NearbyContentViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class NearbyContentViewController: CenterViewController,UITableViewDelegate, UITableViewDataSource , ESTBeaconManagerDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var Requested: [String] = [""]
    var contentList = [Content]()
    var uid : Int = NSUserDefaults.standardUserDefaults().integerForKey("id");

    
    //This manager is for ranging
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "MyBeacon")
    
    //Here we will search for content nearby
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
      /*  
        //Dummy data
        var c = Content()
        c.Title = "Title1"
        c.contentId = 106
        contentList.append(c)
    
        var c1 = Content()
        c1.Title = "HERE!!"
        c1.contentId = 105
        contentList.append(c1)
self.tableView.reloadData()*/
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
       return contentList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath)
    as! ContentTableCellViewController
    
        cell.Title.text = contentList[indexPath.row].Title
   
        cell.tag = contentList[indexPath.row].contentId!
        
        cell.ViewContentButton.tag = contentList[indexPath.row].contentId!
        
        cell.SaveButton.tag = indexPath.row
        
        return cell
        
    }

    @IBAction func save(sender: UIButton) {
        
        let imageFull = UIImage(named: "starF.png") as UIImage!
        let imageEmpty = UIImage(named: "star.png") as UIImage!
        if (sender.currentImage == imageFull)
        {//content saved -> user wants to delete save
            sender.setImage(imageEmpty, forState: .Normal)
            Content().unsaveContent(uid, cid: contentList[sender.tag].contentId!)
        }
        else
        {//content is not saved -> user wants to save
            sender.setImage(imageFull, forState: .Normal)
            let image = UIImage(named: "starF.png") as UIImage!
            sender.setImage(image, forState: .Normal)
            Content().saveContent(uid, cid: contentList[sender.tag].contentId!)
        }
    }
   
 
    
    override func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?)
    {        print("in segue")

        if (segue.identifier == "ShowView")
        {
            let upcoming: ContentForAttendeeViewController = segue.destinationViewController as! ContentForAttendeeViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let cid = contentList[indexPath.row].contentId
            
            let imageFull = UIImage(named: "starF.png") as UIImage!
            let imageEmpty = UIImage(named: "star.png") as UIImage!
            
            upcoming.cid = cid!
            
            let content = Content()
            
            content.ViewContent(cid!, UserID: uid){
                (content:Content) in
                dispatch_async(dispatch_get_main_queue()) {
                    upcoming.content = content
                    print(content)
                    //  self.commentsTable.reloadData()
                    upcoming.abstract.text = content.Abstract
                    upcoming.pdfURL = content.Pdf
                    if(upcoming.pdfURL == "No PDF"){
                        upcoming.pdf.enabled = false
                    }
                    upcoming.vidURL = content.Video
                    if(upcoming.vidURL == "No Video"){
                        upcoming.video.enabled = false
                    }
                    upcoming.navbar.title = content.Title
                    upcoming.images = content.Images
                    print(content.like)
                    print(content.dislike)
                    
                    if(upcoming.content.like==1){
                        upcoming.likeButton.setImage(UIImage(named: "like.png"), forState: UIControlState.Normal)
                    }
                    else if (upcoming.content.dislike==1){
                        upcoming.dislikeButton.setImage(UIImage(named: "dislike.png"), forState: UIControlState.Normal)
                    }
                    
                    if ( self.contentList[indexPath.row].save)
                    {
                        upcoming.save.setImage(imageFull, forState: .Normal)
                    }
                    else
                    {//content is not saved -> user wants to save
                        upcoming.save.setImage(imageEmpty, forState: .Normal)
                        
                    }
                    
                    
                }
            }
            
            
        
        
        /*var upcoming: ContentForAttendeeViewController = segue.destinationViewController as! ContentForAttendeeViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        
           let cid = contentList[indexPath.row].contentId
          var content: Content = Content()
            upcoming.cid = cid
        
      Content().ViewContent(cid, UserID: uid){
            (content:Content) in
            dispatch_async(dispatch_get_main_queue()) {
                upcoming.content = content
                upcoming.commentsTable.reloadData()
                upcoming.abstract.text = content.Abstract
                upcoming.pdf.text = content.Pdf
                upcoming.video.text = content.Video
                upcoming.navbar.title = content.Title
                upcoming.images = content.Images
                print(upcoming.content.like)
                print(upcoming.content.dislike)
                if(upcoming.content.like==1){
                    upcoming.likeButton.setImage(UIImage(named: "like.png"), forState: UIControlState.Normal)
                }
                else if (upcoming.content.dislike==1){
                    upcoming.dislikeButton.setImage(UIImage(named: "dislike.png"), forState: UIControlState.Normal)
                }
            }

        }
    upcoming.content = content*/
        }
    }
    
    func loadContent (major: NSNumber, minor: NSNumber)
    {
       
        //Col::(ContentID, Title, Abstract, Sharecounter, Label, EventID)
        print("HERE IN PHPget \(major):\(minor)")
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/getContent.php")!)
        request.HTTPMethod = "POST";
        let postString = "major=\(major)&minor=\(minor)&uid=\(uid)";

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
                //For each beacon in array
                for beacon in beacons {
                    //Check if the content was requested
                    if (!Requested.contains("\(beacon.major):\(beacon.minor)") && ((beacon.proximity == .Immediate) || (beacon.proximity == .Near)))                    {//If not request content then add to requested array
                        loadContent(beacon.major, minor: beacon.minor)
                        Requested.append("\(beacon.major):\(beacon.minor)")
                    }

                }

             self.tableView.reloadData()
            
    }
    
    
    
}