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
    
    @IBOutlet var EventLogo: UIButton!
    @IBOutlet var EventDate: UITextField!
    @IBOutlet var EventWebsite: UITextField!
    @IBOutlet var EventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDate.delegate = self
        EventWebsite.delegate = self
        EventName.delegate = self
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func save(sender: AnyObject) {
        var name = EventName.text!
        var website = EventWebsite.text!
        var  date = EventDate.text!
        
        if (EventName.text == "" || EventDate.text == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            var e : Event = Event()
            //TODO: نوف عدلي هذا لحق الابديت بدال الاد
            //e.AddEvent (name, web: website, date: date, logo:)
        }
    }
    
    
    func displayMessage(title: String, message: String){
        
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
   
}