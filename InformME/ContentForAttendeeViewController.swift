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

class ContentForAttendeeViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource,  UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate {
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var commentsTable: UITableView!
    @IBOutlet var abstract: UILabel!
    @IBOutlet var pdf: UIButton!
    @IBOutlet var video: UIButton!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var commentField: UITextField!
    var content: Content = Content()
    var cid: Int = 105
    var uid: Int = NSUserDefaults.standardUserDefaults().integerForKey("id")
    var images: [UIImage] = []
    @IBOutlet var addComment: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        commentField.delegate=self
        self.abstract.numberOfLines = 0
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       commentsTable.delegate = self;
       commentsTable.dataSource = self;
      content.ViewContent(cid, UserID: uid){
            (content:Content) in
            dispatch_async(dispatch_get_main_queue()) {
                self.content = content
                 self.commentsTable.reloadData()
                self.abstract.text = self.content.Abstract
                self.pdf.setTitle(self.content.Pdf, forState: UIControlState.Normal)
                self.video.setTitle(self.content.Video, forState: UIControlState.Normal)
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
    

    @IBAction func openLink(sender: UIButton) {
        let openLink = NSURL(string : sender.currentTitle!)
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func shareContent(sender: AnyObject) {
        
        
       let actionSheet = UIAlertController(title: "", message: "انشر المحتوى عبر", preferredStyle: UIAlertControllerStyle.ActionSheet)
       
       
        let tweetAction = UIAlertAction(title: "تويتر", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
         let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterComposeVC.setInitialText("\(self.abstract.text)\(self.pdf.currentTitle)")
                self.presentViewController(twitterComposeVC, animated: true, completion: nil)
                self.content.shareContent(self.content.contentId!){
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
    
    //MARK: -- Comments Table ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCellController
        let maindata = self.content.comments[indexPath.row].comment
        cell.comment.text = maindata as String
        let username = self.content.comments[indexPath.row].user.username
        cell.user.text = username as String
        
        print("user id",self.content.comments[indexPath.row].user.userID )
        if(self.content.comments[indexPath.row].user.userID == self.uid){
            cell.deleteButton.hidden = false
            self.commentField.enabled = false
            self.addComment.enabled = false
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
        self.content.likeContent(self.content.contentId!, uid: self.uid){
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
            self.content.updateEvaluation(self.content.contentId!, uid: self.uid, likeNo: 1, dislikeNo: 0){
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
        self.content.disLikeContent(self.content.contentId!, uid: self.uid){
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
            self.content.updateEvaluation(self.content.contentId!, uid: self.uid, likeNo: 0, dislikeNo: 1){
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
        comment.user.userID = self.uid
        comment.comment = self.commentField.text!
        comment.contentID = self.content.contentId!
        if(self.commentField.text! != ""){
        //TODO: --Check if comment added succesfully :) --
        self.content.saveComment(comment){
            (done:Bool) in
        dispatch_async(dispatch_get_main_queue()) {
            print("I am cool")
            self.commentField.text! = ""
            self.content.comments.append(comment)
            self.commentsTable.reloadData()
        }
        }
        }
        else
        {
                let alert = UIAlertController(title: "", message: " يرجى كتابة تعليق ", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                    
                    // self.dismissViewControllerAnimated(true, completion: nil)
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteComment(){

        self.content.deleteComment(self.content.contentId!,uid: self.uid){
            (done:Bool) in
            dispatch_async(dispatch_get_main_queue()) {
                print("I am cool")
                self.commentsTable.reloadData()

            }
        }
    }//end delete comment fun
    
    @IBAction func save(sender: UIButton) {
        
        let imageFull = UIImage(named: "starF.png") as UIImage!
        let imageEmpty = UIImage(named: "star.png") as UIImage!
        if (sender.currentImage == imageFull)
        {//content saved -> user wants to delete save
            sender.setImage(imageEmpty, forState: .Normal)
            Content().unsaveContent(uid, cid: self.cid)
        }
        else
        {//content is not saved -> user wants to save
            sender.setImage(imageFull, forState: .Normal)
            let image = UIImage(named: "starF.png") as UIImage!
            sender.setImage(image, forState: .Normal)
            Content().saveContent(uid, cid: self.cid)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}//end class