//
//  BeaconViewController.swift
//  InformME
//
//  Created by sara on 4/24/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var TTitle: UITextField!
    @IBOutlet weak var Abstract: UITextField!
    @IBOutlet weak var Video: UITextField!
    @IBOutlet weak var PDF: UITextField!
    
    var cellContent = [String]()
    var numRow:Int?
    
      @IBAction func Submit(sender: AnyObject) {
        var title = TTitle.text!
        var abstract = Abstract.text!
        var video = Video.text!
        var pdf = PDF.text!
        
        var c : Content = Content()
        
        c.saveContent(title,abstract: abstract,video: video,Pdf: pdf){
            (flag:Bool) in
            //we should perform all segues in the main thread
            dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("addContent", sender:sender)
            }}
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TTitle.delegate = self
        Abstract.delegate = self
        Video.delegate = self
        PDF.delegate = self
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
