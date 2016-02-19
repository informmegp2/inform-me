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
    
    func checkDate (ddate: String) -> Bool {
        if  (ddate.rangeOfString("[0-9]{4}-[0-9]{2}-[0-9]{2}", options: .RegularExpressionSearch) != nil){
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
            }}
        
        return false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteEvent(sender: AnyObject) {
        var alertController = UIAlertController(title: "", message: "هل أنت متأكد من رغبتك بالحذف", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let e:Event = Event()
            e.DeleteEvent(self.evid)
            self.performSegueWithIdentifier("showEvents", sender:sender)

            //self.deleteBeacon(b.Label)
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func save(sender: AnyObject) {
        
        let name = EventName.text!
        let website = EventWebsite.text!
        let  date = EventDate.text!
        var flag : Bool = false
        let dateVlidation = checkDate(date)
        if (EventName.text == "" || EventDate.text == "") {
            displayMessage("", message: "يرجى إدخال كافة الحقول")
        }
        else if(!dateVlidation){
            
            displayMessage("", message: "يرجى إدخال تاريخ الحدث بشكل الصحيح")
        }

        else {
         //   var alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
            
       
          //  var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                //UIAlertAction in
              //  NSLog("OK Pressed")
                
                var e : Event = Event()
                e.updateEvent(self.evid,name: name, web: website, date: date, logo: self.EventLogo.backgroundImageForState(.Normal)!)
                
                
                
            
                self.performSegueWithIdentifier("alertPressedOK", sender:sender)
                
                
            //}
            
           // var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
            //    UIAlertAction in
            //    NSLog("Cancel Pressed")
           // }
          //  alertController.addAction(okAction)
           // alertController.addAction(cancelAction)
            
            //self.presentViewController(alertController, animated: true, completion: nil)
    }
    }
    
    func displayMessage(title: String, message: String){
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
   
}