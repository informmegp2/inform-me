//
//  ContentForOrganizer.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class ContentForOrganizerViewController: UIViewController {
    
    var contentid: Int=1;
    var ttitle: String=""
    var abstract: String=""
    var video: String=""
    var pdf: String=""
    //  var evlogo: UIImage?
    
    
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
        
        // Do any additional setup after loading the view.
    }
    
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
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}