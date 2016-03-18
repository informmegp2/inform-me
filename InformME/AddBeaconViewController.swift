//
//  BeaconViewController.swift
//  InformME
//
//  Created by sara on 4/24/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddBeaconViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var Label: UITextField!
    @IBOutlet weak var Minor: UITextField!
    @IBOutlet weak var Major: UITextField!
    
    //var llabel:String?
    //var major:Int?
    //var minor:Int?
    var cellContent = [String]()
    var numRow:Int?
    var labels = [String]()
    
    @IBAction func Submit(sender: AnyObject) {
        
        var minor = Minor.text!
        var llabel = Label.text!
        var  major = Major.text!
        var flag : Bool = false
        
        let uid=13
        
        if (Minor.text == "" || Major.text == "" || llabel == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
               // self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
                   }
        else {

            if  labels.contains(llabel) {
                let alert = UIAlertController(title: "", message: " إسم البيكون مستخدم مسبقا \n الرجاء إختيار إسم أخر ", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                    
                    // self.dismissViewControllerAnimated(true, completion: nil)
                    
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
            else {
            var b : Beacon = Beacon()
            b.addBeacon (llabel, major: major,minor:minor){
                (flag:Bool) in
                //we should perform all segues in the main thread
                dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("addBeacon", sender:sender)
                }}
            }}
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Minor.delegate = self
        Major.delegate = self
        Label.delegate = self
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
