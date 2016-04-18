//
//  ManageContentViewController.swift
//  InformME
//
//  Created by sara on 5/4/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class ManageContentsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate ,ContentCellDelegate  {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var contentInfo: [Content] = []
    var content: Content = Content()
    var EID: Int?
    
    
    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        content.requestcontentlist(EID!){
            (contentInfo:[Content]) in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentInfo = contentInfo
                self.tableView.reloadData()
            }
            
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.reloadData();
        //setup tint color for tha back button.
    }
    
    
    @IBAction func add(sender: AnyObject) {
                self.performSegueWithIdentifier("add", sender: self)
    }
    @IBAction func addcontent(sender: AnyObject) {
        self.performSegueWithIdentifier("addContentbutton", sender: self)
        print("Button PRESSED, segue")
    }
    
    @IBAction func out(sender: AnyObject) {
        
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        let current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    
                    self.performSegueWithIdentifier("backtologin", sender: self)
                    
                    
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
        
        
        
    }//end out addContent
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath) as! ContentTableCellViewController
        //var maindata = values[indexPath.row].minor
        var c: Content = Content()
        c = self.contentInfo[indexPath.row] 
        
        cell.Title.text = c.Title
        
        return cell
        
    }
    
    
    func showContentDetails(){
        performSegueWithIdentifier("showContentDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "showContentDetails") {
            let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
            let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
            print(cellIndexPath?.row)
            var c : Content = Content()
            c=contentInfo[(cellIndexPath?.row)!] 
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let detailVC = segue.destinationViewController as! ContentForOrganizerViewController
            
            detailVC.ttitle=c.Title
            detailVC.abstract=c.Abstract
            detailVC.pdf=c.Pdf
            detailVC.video=c.Video
            detailVC.contentid=c.contentId
            detailVC.images = c.Images
            detailVC.label=c.label
            detailVC.EID = self.EID
            
            
        }
        else if (segue.identifier == "addContentbutton") {
            let addVC = segue.destinationViewController as! AddContentViewController
            addVC.EID =  self.EID!
            print("This is Hi -------------- \(addVC.EID)")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return contentInfo.count;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}