//
//  UpdateBeaconViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class UpdateBeaconViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet  var Label: UITextField!
    @IBOutlet  var Major: UITextField!
    @IBOutlet  var Minor: UITextField!
    
    var mmajor:String=""
    var mminor:String=""
    var llabel:String=""
    var temp:String=""
    
    var cellContent = [String]()
    var numRow:Int?
    
    
    @IBAction func Submit(sender: AnyObject) {
        
        var minor = Minor.text!
        var llabel = Label.text!
        var  major = Major.text!

            var b : Beacon = Beacon()
            //TODO: ساره عدلي هذا لحق الابديت بدال الاد
            b.updateBeacon (llabel, major: major,minor:minor , Temp: temp)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Label.text = llabel
        self.Major.text = mmajor
        self.Minor.text = mminor
        temp = llabel
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
