//
//  ContentForAttendeeViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/22/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
import Social

class ContentForAttendeeViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource,  UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet var commentsTable: UITableView!
    @IBOutlet var abstract: UILabel!
    @IBOutlet var pdf: UILabel!
    @IBOutlet var video: UILabel!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var commentField: UITextField!
    var content: Content = Content()
    var cid: Int = 105
    var uid: Int = 29
    var images: [UIImage] = []
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        commentsTable.delegate = self;
        commentsTable.dataSource = self;
        content.ViewContent(cid, UserID: uid){
            (content:Content) in
            dispatch_async(dispatch_get_main_queue()) {
                self.content = content
                self.commentsTable.reloadData()
                self.abstract.text = self.content.Abstract
                self.pdf.text = self.content.Pdf
                self.video.text = self.content.Video
                self.navbar.title = self.content.Title
                self.images = self.content.Images
                print(self.content.like)
                print(self.content.dislike)
                if(self.content.like==1){
                     self.likeButton.setImage(UIImage(named: "like.png"), forState: UIControlState.Normal)
                }
                else if (self.content.dislike==1){
                    self.dislikeButton.setImage(UIImage(named: "dislike.png"), forState: UIControlState.Normal)
                }
          self.collectionView.delegate = self
          self.collectionView.dataSource = self
            }
        }
        
    }
    
    // the controller that has a reference to the collection view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = self.collectionView.contentInset
        let value = (self.view.frame.size.width - (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = value
        insets.right = value
        self.collectionView.contentInset = insets
        print("\(value)")
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.cellImage.image = images[indexPath.row]
        return cell
    }

    //MARK -- Social Media --
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func shareContent(sender: AnyObject) {
        
        
       let actionSheet = UIAlertController(title: "", message: "انشر المحتوى عبر", preferredStyle: UIAlertControllerStyle.ActionSheet)
       
       
        let tweetAction = UIAlertAction(title: "تويتر", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
         let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterComposeVC.setInitialText("test post content from our app")
                self.presentViewController(twitterComposeVC, animated: true, completion: nil)
                self.content.shareContent(self.cid){
                    (done:Bool) in
                    dispatch_async(dispatch_get_main_queue()) {
                        print("I am cool")
                      
                       
                    }
                }

                
            }
            else {
               self.showAlertMessage("يجب عليك أولًا تسجيل الدخول بتويتر")
            }
        }
        let moreAction = UIAlertAction(title: "غير ذلك", style: UIAlertActionStyle.Default) { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: ["test code"], applicationActivities: nil)
            
            activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }
    
        
        let dismissAction = UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
        
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

        
    } //end out */ backtologin
    
    //MARK: -- Comments Table ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCellController
        let maindata = self.content.comments[indexPath.row].comment
        cell.comment.text = maindata as String
        let username = self.content.comments[indexPath.row].user.username
        cell.user.text = username as String
        if(self.content.comments[indexPath.row].user.userID == 29){
            cell.deleteButton.hidden = false
            
            //NSUserDefaults.standardUserDefaults().integerForKey("id")
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return self.content.comments.count;
    }
    
    @IBOutlet var dislikeButton: UIButton!
    
    @IBAction func likeContent(sender: AnyObject) {
          if (self.content.like==0 && self.content.dislike==0){
        self.content.likeContent(self.cid, uid: self.uid){
            (done:Bool) in
            dispatch_async(dispatch_get_main_queue()) {
                print("I am cool")
      self.likeButton.setImage(UIImage(named: "like.png"), forState: UIControlState.Normal)
                self.content.like=1
                print(self.content.like)
                print(self.content.dislike)
            }
            }}
          else if (self.content.dislike==1){
            self.content.updateEvaluation(self.cid, uid: self.uid, likeNo: 1, dislikeNo: 0){
                (done:Bool) in
                dispatch_async(dispatch_get_main_queue()) {
            self.likeButton.setImage(UIImage(named: "like.png"), forState: UIControlState.Normal)
            self.content.like=1
            self.content.dislike=0
            self.dislikeButton.setImage(UIImage(named: "dislike-g.png"), forState: UIControlState.Normal)
            print(self.content.like)
            print(self.content.dislike)
                }}}

    }
    
    
    
    @IBAction func dislikeContent(sender: AnyObject) {
        if (self.content.like==0 && self.content.dislike==0){
        self.content.disLikeContent(self.cid, uid: self.uid){
            (done:Bool) in
            dispatch_async(dispatch_get_main_queue()) {
                print("I am cool")
                 self.dislikeButton.setImage(UIImage(named: "dislike.png"), forState: UIControlState.Normal)
                self.content.dislike=1
                print(self.content.like)
                print(self.content.dislike)
            }}
        }
        else if (self.content.like==1){
            self.content.updateEvaluation(self.cid, uid: self.uid, likeNo: 0, dislikeNo: 1){
                (done:Bool) in
                dispatch_async(dispatch_get_main_queue()) {

            self.dislikeButton.setImage(UIImage(named: "dislike.png"), forState: UIControlState.Normal)
            self.content.like=0
            self.content.dislike=1
            self.likeButton.setImage(UIImage(named: "like-g.png"), forState: UIControlState.Normal)
            print(self.content.like)
                    print(self.content.dislike)}}
        }
    }
    
    //MARK: --- New Comment --- 
    
    @IBAction func comment(){
        let comment: Comment = Comment()
        comment.user.userID = 6
            //NSUserDefaults.standardUserDefaults().integerForKey("id")
        comment.comment = self.commentField.text!
        comment.contentID = self.content.contentId
        //TODO: --Check if comment added succesfully :) --
        self.content.saveComment(comment){
            (done:Bool) in
        dispatch_async(dispatch_get_main_queue()) {
            print("I am cool")
            self.content.comments.append(comment)
            self.commentsTable.reloadData()
        }
        }

    }
    
    @IBAction func deleteComment(){
       // self.content.contentId,uid: NSUserDefaults.standardUserDefaults().integerForKey("id")
        self.content.deleteComment(cid,uid: uid){
            (done:Bool) in
            dispatch_async(dispatch_get_main_queue()) {
                print("I am cool")
                self.commentsTable.reloadData()

            }
        }
    }//end delete comment fun
    
}//end class