//
//  EditContentViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class UpdateContentViewController: UIViewController  , UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet var ETitle: UITextField!
    @IBOutlet  var EAbstract: UITextField!
    @IBOutlet  var EPDF: UITextField!
    @IBOutlet  var EVideo: UITextField!
    @IBOutlet var pickerTextField: UITextField!// for assign
    
    var ttitel:String=""
    var aabstract:String=""
    var ppdf:String=""
    var vvideo:String=""
    var tempV:String=""
    var tempP:String=""
    var cid : Int?
    var label:String=""
    
    var cellContent = [String]()
    var numRow:Int?
    var beaconsInfo: [Beacon] = []//nouf add it for assign beacon
    var beacon:Beacon = Beacon()// for assign beacon
    var UserID = 13
    
    
    // for assign
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return beaconsInfo.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return beaconsInfo[row].Label
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = beaconsInfo[row].Label
    }

    @IBAction func Submit(sender: AnyObject) {
        var title = ETitle.text!
        var abstract = EAbstract.text!
        var pdf = EPDF.text!
        var video = EVideo.text!
        var blabel = pickerTextField.text!
        var flag : Bool = false
        
        var alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")

            var c : Content = Content()
            c.updateContent (title, abstract: abstract,video: pdf , Pdf: video ,bLabel: blabel, TempV: self.tempV , TempP: self.tempP , cID: self.cid!){
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

            c.DeleteContent(self.cid!)
               // (flag:Bool) in
                //we should perform all segues in the main thread
               // dispatch_async(dispatch_get_main_queue()) {
            if ( c.del){
            self.performSegueWithIdentifier("deleteok", sender:sender)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beacon.requestbeaconlist(UserID){// fo assign beacon
            (beaconsInfo:[Beacon]) in
            dispatch_async(dispatch_get_main_queue()) {
                self.beaconsInfo = beaconsInfo
                print("get info")
                var pickerView = UIPickerView()
                
                pickerView.delegate = self
                
                self.pickerTextField.inputView = pickerView
                
               
            }
            
        }

        self.ETitle.text = ttitel
        self.EAbstract.text = aabstract
        self.EPDF.text = ppdf
        self.EVideo.text = vvideo
        self.pickerTextField.text = label
        tempV=vvideo
        tempP=ppdf

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
