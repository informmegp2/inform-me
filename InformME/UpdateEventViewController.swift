//
//  UpdateEventViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

//
//  EventDetailsViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class UpdateEventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    var evid: Int=1;
    var evname: String=""
    var evwebsite: String=""
    var evdate: String=""
    var evlogo: UIImage?
    @IBOutlet var EventLogo: UIButton!
    @IBOutlet var EventDate: UITextField!
    @IBOutlet var EventWebsite: UITextField!
    @IBOutlet var EventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDate.text = evdate
        EventWebsite.text = evwebsite
        EventName.text = evname
        EventLogo.setBackgroundImage(evlogo, forState: .Normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadImage(sender: AnyObject) {
        print("button pressed")
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        EventLogo.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func dp(sender: UITextField) {
        
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        var datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
        
    }
    func doneButton(sender:UIButton)
    {
        EventDate.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        sender.minimumDate = NSDate()
      

        
        EventDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    func checkDate (ddate: String) -> Bool {
       
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todaysDate:NSDate = NSDate()
            let dayWothFormat = dateFormatter.stringFromDate(todaysDate)
            print(dayWothFormat)
            let date = dateFormatter.dateFromString(dayWothFormat)
            
            let date1 = dateFormatter.dateFromString(ddate)
            
            if date1!.compare(date!) == NSComparisonResult.OrderedDescending
            {
                print("date1 after date2");
                return true
            } else if date1!.compare(date!) == NSComparisonResult.OrderedAscending
            {
                return false
            } else
            {
                return true
            }
        
        return false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func save(sender: AnyObject) {
        let name = EventName.text!
        let website = EventWebsite.text!
        let  date = EventDate.text!
        let dateVlidation = checkDate(date)
        if (EventName.text == "" || EventDate.text == "") {
            displayMessage("", message: "يرجى إدخال كافة الحقول")
        }
        else if(!dateVlidation){
            
            displayMessage("", message: "يرجى إدخال تاريخ الحدث بشكل الصحيح")
        }
        else {
            var alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
            
            // Create the actions
            var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
                let e : Event = Event()
            e.updateEvent (self.evid,name: name, web: website, date: date, logo: self.EventLogo.backgroundImageForState(.Normal)!){
                (flag:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
                    print("Heeeeello")
                    self.performSegueWithIdentifier("alertPressedOK", sender:sender)
                }}

               // e.updateEvent (self.evid,name: name, web: website, date: date, logo: self.EventLogo.backgroundImageForState(.Normal)!)
               
                  //  self.performSegueWithIdentifier("alertPressedOK", sender:sender)
            
                
                
            }
            
            var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel)
                {
               UIAlertAction in
                NSLog("Cancel Pressed")
            }
             //Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func deleteEvent(sender: AnyObject) {
        var alertController = UIAlertController(title: "", message: "هل أنت متأكد من رغبتك بالحذف", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            var e: Event = Event()
                       e.DeleteEvent(self.evid)
             self.performSegueWithIdentifier("deleteok", sender:sender)
        }
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
    func displayMessage(title: String, message: String){
        
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "alertPressedOK") {
            print("segue")
        var detailVC = segue!.destinationViewController as! EventDetailsViewController;
            detailVC.evid = evid
            detailVC.evname=EventName.text!
            detailVC.evwebsite=EventWebsite.text!
            detailVC.evdate=EventDate.text!
           
            detailVC.evlogo=self.EventLogo.backgroundImageForState(.Normal)
        }
        
    }

    
}