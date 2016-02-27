//
//  EditContentViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class UpdateContentViewController: UIViewController  , UITextFieldDelegate{
    
    @IBOutlet var ETitle: UITextField!
    @IBOutlet  var EAbstract: UITextField!
    @IBOutlet  var EPDF: UITextField!
    @IBOutlet  var EVideo: UITextField!

    
    var ttitel:String=""
    var aabstract:String=""
    var ppdf:String=""
    var vvideo:String=""
    var tempV:String=""
    var tempP:String=""
    var cid : Int?
    
    var cellContent = [String]()
    var numRow:Int?
    
    
    @IBAction func Submit(sender: AnyObject) {
        var title = ETitle.text!
        var abstract = EAbstract.text!
        var pdf = EPDF.text!
        var video = EVideo.text!
        var flag : Bool = false
        
        var alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")

            var c : Content = Content()
            c.updateContent (title, abstract: abstract,video: pdf , Pdf: video , TempV: self.tempV , TempP: self.tempP , cID: self.cid!){
                (flag:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
        self.performSegueWithIdentifier("alertPressedOK", sender:sender)
            }
            
            }}
        
        var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "alertPressedOK") {
            var detailVC = segue!.destinationViewController as! ContentForOrganizerViewController;
            detailVC.ttitle=ETitle.text!
            detailVC.abstract=EAbstract.text!
            detailVC.pdf=EPDF.text!
            detailVC.video=EVideo.text!
            detailVC.contentid=cid!

            
        }
        
    }

    @IBAction func deleteContent(sender: AnyObject) {
        var alertController = UIAlertController(title: "", message: "هل أنت متأكد من رغبتك بالحذف", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            var c: Content = Content()

            c.DeleteContent(self.cid!){
                (flag:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("deleteok", sender:sender)
                }} }
        var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ETitle.text = ttitel
        self.EAbstract.text = aabstract
        self.EPDF.text = ppdf
        self.EVideo.text = vvideo
        tempV=vvideo
        tempP=ppdf

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
