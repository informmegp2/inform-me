//
//  ContentForOrganizer.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class ContentForOrganizerViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var contentid: Int=105;
    var ttitle: String=""
    var abstract: String=""
    var video: String=""
    var pdf: String=""
    var label: String=""
    var images: [UIImage]=[]
   // var cid : Int?
    
    @IBOutlet var TTitle: UINavigationItem!

    @IBOutlet var AAbstract: UILabel!
    @IBOutlet var PDF: UILabel!
    @IBOutlet var VVideo: UILabel!
    
    
    // @IBOutlet var logo: UIImageView!
    override func viewDidLoad() {

        super.viewDidLoad()
        self.TTitle.title = ttitle
        self.AAbstract.text = abstract
        self.PDF.text = pdf
        self.VVideo.text=video
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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
        
        
    
    func editContent(){
        performSegueWithIdentifier("editContent", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if (segue.identifier == "editContent") {
            var detailVC = segue!.destinationViewController as! UpdateContentViewController
            
            detailVC.ttitel=TTitle.title!
            detailVC.aabstract=AAbstract.text!
            detailVC.ppdf=PDF.text!
            detailVC.vvideo=VVideo.text!
            detailVC.cid=contentid
            detailVC.label=self.label
            detailVC.images = self.images
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
}