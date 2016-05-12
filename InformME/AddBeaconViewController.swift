//
//  BeaconViewController.swift
//  InformME
//
//  Created by sara on 4/24/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddBeaconViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, ESTBeaconManagerDelegate {
   
    var Requested: [String] = [""]

    
    @IBOutlet weak var Label: UITextField!
    @IBOutlet weak var Minor: UITextField!
    @IBOutlet weak var Major: UITextField!
    var cellContent = [String]()
    var numRow:Int?
    var labels = [String]()
    var UID = [String]()
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
   
    //This manager is for ranging
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "MyBeacon")
    

    // Add beacon
    @IBAction func Submit(sender: AnyObject) {
        
        let minor = Minor.text!
        let llabel = Label.text!
        let  major = Major.text!
        
        if (Minor.text == "" || Major.text == "" || llabel == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            if UID.contains(String(UserID)) && labels.contains(llabel) {
                let alert = UIAlertController(title: "", message: " إسم البيكون مستخدم مسبقا \n الرجاء إختيار إسم أخر ", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    
                    let b : Beacon = Beacon()
                    b.addBeacon (llabel, major: major,minor:minor){
                        (flag:Bool) in
                        //we should perform all segues in the main thread
                        dispatch_async(dispatch_get_main_queue()) {
                            self.performSegueWithIdentifier("addBeacon", sender:sender)
                        }}}
                let cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                // Present the controller
                self.presentViewController(alertController, animated: true, completion: nil)
            }}
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Minor.delegate = self
        Major.delegate = self
        Label.delegate = self
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()

    }
    
    //To start/stop ranging as the view controller appears/disappears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This method will be called everytime we are in the range of beacons
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
                       inRegion region: CLBeaconRegion) {
        //Get the array of beacons in range
            //For each beacon in array
            for beacon in beacons {
                //Check if the content was requested
                if(beaconDiscovered==0){
                if (!Requested.contains("\(beacon.major):\(beacon.minor)"))
                {//If not request content then add to requested array
                    loadContent(beacon.major, minor: beacon.minor)
                    Requested.append("\(beacon.major):\(beacon.minor)")
                    beaconDiscovered=beaconDiscovered+1;
                    }}
                else if((beacon.major != Int(Major.text!)) && (beacon.minor != Int(Minor.text!)) && !alertOn){
                    let alert = UIAlertController(title: "", message: " تم اكتشاف أكثر من بيكون، الرجاء قلبها و،المحاولة من جديد لضمان الدقة ", preferredStyle: UIAlertControllerStyle.Alert)
                    self.alertOn = true
                    alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                        self.Minor.text = "";
                        self.Major.text = "";
                        self.view.reloadInputViews()
                        self.beaconDiscovered=0
                        self.Requested = [""]
                        // self.dismissViewControllerAnimated(true, completion: nil)
                        self.alertOn = false
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            }
    }
    var alertOn = false
    var beaconDiscovered = 0
    func loadContent (major: NSNumber, minor: NSNumber)
    {
        
        //Col::(ContentID, Title, Abstract, Sharecounter, Label, EventID)
        print("HERE IN PHPget \(major):\(minor)")
        
        Minor.text = String(minor);
        Major.text = String(major);
        self.view.reloadInputViews()
    }
    
    var window:UIWindow!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("beaconsMng") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
            containerViewController.centerViewController.delegate?.collapseSidePanels!()
            
        }
        
    
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    

    @IBOutlet var scrollView: UIScrollView!
    func textFieldDidBeginEditing(textField: UITextField) {
        scrollView.setContentOffset((CGPointMake(0, 150)), animated: true)
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset((CGPointMake(0, 0)), animated: true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
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
