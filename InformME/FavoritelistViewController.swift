//
//  FavoritelistViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class FavoritelistViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var contentList = [Content]()
    var uid : Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
    
    @IBOutlet var tableView: UITableView!
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
        
    } //end out */ backtologin
    
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      //  loadFavorite ()
       
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        loadFavorite () {
            () in
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
      // self.tableView.reloadData()
       
    }
    
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath) as! ContentTableCellViewController
        
     
        cell.Title.text = contentList[indexPath.row].Title
        
        cell.tag = contentList[indexPath.row].contentId!
        
        cell.ViewContentButton.tag = contentList[indexPath.row].contentId!
        
        cell.SaveButton.tag = indexPath.row
        
        print("HERE IN CELL")
        
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
           //  let imageEmpty = UIImage(named: "star.png") as UIImage!
            
            upcoming.cid = cid!
            
        let content = Content()
            
            content.ViewContent(cid!, UserID: uid){
                (content:Content) in
                dispatch_async(dispatch_get_main_queue()) {
                    upcoming.content = content
                      print(content)
                    //  self.commentsTable.reloadData()
                    upcoming.abstract.text = content.Abstract
                    upcoming.pdf.setTitle(content.Pdf, forState: UIControlState.Normal)
                    upcoming.video.setTitle(content.Video, forState: UIControlState.Normal)
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
                    
                        upcoming.save.setImage(imageFull, forState: .Normal)


                
                }
            }
            
            
        }}
    
    func loadFavorite (completion: () -> Void)
    {
        
        //Col::(ContentID, Title, Abstract, Sharecounter, Label, EventID)
       
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/getFavourite.php")!)
        request.HTTPMethod = "POST";
        
        let postString = "uid=\(uid)";
        
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
                        print(jsonResults)
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
            
            completion()
        }
        task.resume()
        
    }


    
}