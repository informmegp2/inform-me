//
//  ContentForOrganizer.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class ContentForOrganizerViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var contentid: Int?;
    var ttitle: String=""
    var abstract: String=""
    var video: String=""
    var pdf: String=""
    var label: String=""
    var images: [UIImage]=[]
    var EID : Int?
    // var cid : Int?
    var content: Content!
    @IBOutlet var commentsTable: UITableView!
    @IBOutlet var TTitle: UINavigationItem!
    
    @IBOutlet var AAbstract: UILabel!
    @IBOutlet var PDF: UILabel!
    @IBOutlet var VVideo: UILabel!
     var like: String!
     var dislike: String!
     var share: String!
    var comment: String!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var dislikes: UILabel!
    @IBOutlet weak var shares: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    // @IBOutlet var logo: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.commentsTable.delegate = self
        self.commentsTable.dataSource = self
        self.TTitle.title = ttitle
        self.AAbstract.text = abstract
        self.AAbstract.numberOfLines = 0

        self.PDF.text = pdf
        self.VVideo.text=video
        self.likes.text = like
        self.dislikes.text = dislike
        self.shares.text = share
        self.comments.text = comment
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.commentsTable.reloadData()
        // Do any additional setup after loading the view.
        
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
    
    
    
    func editContent(){
        performSegueWithIdentifier("editContent", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "editContent") {
            let detailVC = segue.destinationViewController as! UpdateContentViewController
            
            detailVC.ttitel=TTitle.title!
            detailVC.aabstract=AAbstract.text!
            detailVC.ppdf=PDF.text!
            detailVC.vvideo=VVideo.text!
            detailVC.cid=contentid
            detailVC.label=self.label
            detailVC.images = self.images
            detailVC.EID = self.EID
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("Collection View?")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.cellImage.image = images[indexPath.row]
        return cell
    }
    
    
    //MARK: -- Comments Table ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCellController
        let maindata = self.content.comments[indexPath.row].comment
        cell.comment.text = maindata as String
        let username = self.content.comments[indexPath.row].user.username
        cell.user.text = username as String
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return self.content.comments.count;
    }
    
}