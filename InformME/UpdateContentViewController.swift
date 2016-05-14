//
//  EditContentViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class UpdateContentViewController: UIViewController  , UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage]=[]
    
    @IBOutlet var ETitle: UITextField!
    @IBOutlet  var EAbstract: UITextView!
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
    var EID :Int?
    var cellContent = [String]()
    var numRow:Int?
    var beaconsInfo: [Beacon] = []//nouf add it for assign beacon
    var beacon:Beacon = Beacon()// for assign beacon
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
    var pickerView = UIPickerView() 
    
    // for assign
    
    @IBAction func assignBeacon(sender: AnyObject) {
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        
        pickerView.dataSource = self
        inputView.addSubview(pickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(UpdateContentViewController.doneButton(_:)), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        (sender as! UITextField).inputView = inputView
        (sender as! UITextField).delegate = self
        
        
    }
    func doneButton(sender:UIButton)
    {
        pickerTextField.resignFirstResponder()
        let row = pickerView.selectedRowInComponent(0);
        NSLog("value L %d", row)
        pickerView(pickerView, didSelectRow: row, inComponent:0)
        
    }
    
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
        if (beaconsInfo.count == 0){
        pickerTextField.text=""}
        else{
            pickerTextField.text = beaconsInfo[row].Label}
        
        
    }
    
    @IBAction func Submit(sender: AnyObject) {
        let title = ETitle.text!
        let abstract = EAbstract.text!
        let pdf = EPDF.text!
        let video = EVideo.text!
        let blabel = pickerTextField.text!
        if (ETitle.text == "") {
            let alert = UIAlertController(title: "", message: " يرجى إدخال عنوان المحتوى", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (pickerTextField.text == "") {
            let alert = UIAlertController(title: "", message: " يرجى اختيار بيكون", preferredStyle: UIAlertControllerStyle.Alert)
            
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
            let c : Content = Content()
            if(Reachability.isConnectedToNetwork()){
            c.updateContent (title, abstract: abstract,video: video  , Pdf: pdf ,bLabel: blabel,image: self.images, TempV: self.tempV , TempP: self.tempP ,EID: self.EID!, cID: self.cid!){
                (flag:Bool) in
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("alertPressedOK", sender:sender)
                }
                
            }//end call
            }
            else{
                self.displayAlert("", message: "الرجاء الاتصال بالانترنت")
            }
            }
        
        let cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
        
        } }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "alertPressedOK") {
            print("In prepare for segue")
            let detailVC = segue.destinationViewController as! ContentForOrganizerViewController;
            detailVC.ttitle=ETitle.text!
            detailVC.abstract=EAbstract.text!
            detailVC.pdf=EPDF.text!
            detailVC.video=EVideo.text!
            detailVC.contentid=cid!
            detailVC.images=images
            detailVC.label=pickerTextField.text!
            
        }
        if (segue.identifier == "deleteok") {
            let detailVC = segue.destinationViewController as! ManageContentsViewController
            detailVC.EID=EID
           
            
        }
        
    }
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert
    @IBAction func deleteContent(sender: AnyObject) {
        let alertController = UIAlertController(title: "", message: "هل أنت متأكد من رغبتك بالحذف", preferredStyle: .Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let c: Content = Content()
            if(Reachability.isConnectedToNetwork()){
                c.DeleteContent(self.cid!)}
            else {
                self.displayAlert("",message: "الرجاء الاتصال بالانترنت")
            }
            // (flag:Bool) in
            //we should perform all segues in the main thread
            // dispatch_async(dispatch_get_main_queue()) {
            if ( c.del){
                self.performSegueWithIdentifier("deleteok", sender:sender)
            }}
        let cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
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
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        if(Reachability.isConnectedToNetwork()){
        beacon.requestbeaconlist(UserID){// fo assign beacon
            (beaconsInfo:[Beacon]) in
            dispatch_async(dispatch_get_main_queue()) {
                self.beaconsInfo = beaconsInfo
                print("get info")
               
                
                
            }
            
        }
        }
        else {
            self.displayAlert("", message: "الرجاء الاتصال بالانترنت")
        }
        self.ETitle.text = ttitel
        self.EAbstract.text = aabstract
        self.EPDF.text = ppdf
        self.EVideo.text = vvideo
        self.pickerTextField.text = label
        tempV=vvideo
        tempP=ppdf
        self.ETitle.delegate = self
        self.EAbstract.delegate = self
        self.EPDF.delegate = self
        self.EVideo.delegate = self
        self.pickerTextField.delegate = self
        
    }
    
    @IBOutlet var scrollView: UIScrollView!
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == pickerTextField){
            scrollView.setContentOffset((CGPointMake(0, 200)), animated: true)}
        else {
            scrollView.setContentOffset((CGPointMake(0, 150)), animated: true)}

        
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
    
    // the controller that has a reference to the collection view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = self.collectionView.contentInset
        let value = (self.view.frame.size.width - (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = value
        insets.right = value
        self.collectionView.contentInset = insets
        print("\(value)")
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    var imageNum : Int?
    var cell : UpdateImageCollectionViewCell?
    var i : Int = 0
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("UpdateImageCell", forIndexPath: indexPath) as? UpdateImageCollectionViewCell
        cell!.cellButton.setImage(images[indexPath.row], forState: UIControlState.Normal)
        cell!.cellButton.tag = i
        cell!.cellButton.addTarget(self, action: #selector(UpdateContentViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        imageNum = indexPath.row
        i += 1
        return cell!
    }
    
    var pickerOne : UIImagePickerController?
    var temp : Int?
    func buttonClicked(sender:UIButton)
    {
        pickerOne = UIImagePickerController()
        pickerOne!.delegate = self
        pickerOne!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerOne!, animated: true, completion: nil)
        temp = sender.tag
        
    }
    @IBOutlet var add: UIButton!
    var image : UIImage?
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        if ( temp == 100 ){
            images.append((info[UIImagePickerControllerOriginalImage]as? UIImage)!)
        }
        else {
            image = (info[UIImagePickerControllerOriginalImage]as? UIImage)!
            images.removeAtIndex(temp!)
            images.insert(image!, atIndex: temp!) }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        collectionView.reloadData()
        i=0
        if images.count == 3 {
            add.hidden = true
        }
    }
    
    @IBAction func addImage(sender: AnyObject) {
        pickerOne = UIImagePickerController()
        pickerOne!.delegate = self;
        pickerOne!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerOne!, animated: true, completion: nil)
        temp = 100
    }
    
}






