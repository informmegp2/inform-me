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
    
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
    @IBOutlet var EventLogoo: UIButton!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        EventLogoo.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func dp(sender: UITextField) {
        
       /* var datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)*/
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(AddEventViewController.doneButton(_:)), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(AddEventViewController.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
        
    }
    func doneButton(sender:UIButton)
    {
        EventDate.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    func handleDatePicker(sender: UIDatePicker) {
          sender.minimumDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
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
    }
   
    @IBAction func save(sender: AnyObject) {
        let name = EventName.text!
        let website = EventWebsite.text!
        let  date = EventDate.text!
       
        if (EventName.text == "" || EventDate.text == "") {
            displayAlert("", message: "يرجى إدخال كافة الحقول")
               }
      
        else if(EventDate.text != "" && !checkDate(date)){
            
            displayAlert("", message: "يرجى إدخال تاريخ الحدث بشكل الصحيح")
            }
        else {
            print(EventName.text)
            let e : Event = Event()
            e.AddEvent (UserID, name: name, web: website, date: date, logo: EventLogoo.backgroundImageForState(.Normal)!){
                (flag:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
                  self.performSegueWithIdentifier("addEvent", sender:sender)
                }}

          

        }
     
        
    }
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: nil ))
        
         self.presentViewController(alert, animated: true, completion: nil)
        
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
