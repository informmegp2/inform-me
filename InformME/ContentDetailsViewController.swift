//
<<<<<<< HEAD
//  EventDetailsViewController.swift
//  InformME
//
//  Created by nouf abdullah on 4/30/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class ContentDetailsViewController: UIViewController {
    
    var contentid: Int=1;
    var ttitle: String=""
    var abstract: String=""
    var video: String=""
    var pdf: String=""
    //  var evlogo: UIImage?
    
    
    @IBOutlet var TTitle: UILabel!
    @IBOutlet var AAbstract: UILabel!
    @IBOutlet var PDF: UILabel!
    @IBOutlet var VVideo: UILabel!
    
    
    // @IBOutlet var logo: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print ("dsds"+abstract)
        self.TTitle.text = ttitle
        self.AAbstract.text = abstract
        self.PDF.text = pdf
        self.VVideo.text=video
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
=======
//  ContentDetailsViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/17/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class ContentDetailsViewController: UIViewController {
}
>>>>>>> origin/master
