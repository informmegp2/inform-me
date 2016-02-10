//
//  EventDetailsViewController.swift
//  InformME
//
//  Created by nouf abdullah on 4/30/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
   
    var evid: Int=1;
    var evname: String=""
    var evwebsite: String=""
    var evdate: String=""
    @IBOutlet var ddate: UILabel!
    @IBOutlet var wwebsite: UILabel!
    @IBOutlet var nnamd: UINavigationItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.wwebsite.text = evwebsite
        self.ddate.text = evdate
        self.nnamd.title = evname
        print("here \(evid)")
      
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
