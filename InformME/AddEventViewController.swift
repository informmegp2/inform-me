//
//  AddEventViewController.swift
//  InformME
//
//  Created by nouf abdullah on 4/28/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit
import Foundation
class AddEventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var EventLogoo: UIButton!
    @IBOutlet var EventLogo: UIImageView!
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
   
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        EventLogoo.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
        
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
   
    @IBAction func save(sender: AnyObject) {
        let name = EventName.text!
        let website = EventWebsite.text!
        let  date = EventDate.text!
       let dateVlidation = checkDate(date)
        if (EventName.text == "" || EventDate.text == "") {
            displayAlert("", message: "يرجى إدخال كافة الحقول")
               }
       else if(!dateVlidation){
            
            displayAlert("", message: "يرجى إدخال تاريخ الحدث بشكل الصحيح")
            }
        else {
            print(EventName.text)
            let e : Event = Event()
            e.AddEvent (name, web: website, date: date, logo: EventLogoo.backgroundImageForState(.Normal)!)
                    }
     
        
    }
    
    func displayAlert(title: String, message: String) {
        
        var alerts = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alerts.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
                       
        })))
        
         self.presentViewController(alerts, animated: true, completion: nil)
        
    }//end fun display alert
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
   
    
    

}
