//
//  EditContentViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/16/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class UpdateContentViewController: UIViewController  , UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage]=[]
    
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
    var EID :Int?
    var cellContent = [String]()
    var numRow:Int?
    var beaconsInfo: [Beacon] = []//nouf add it for assign beacon
    var beacon:Beacon = Beacon()// for assign beacon
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
    
    
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
            c.updateContent (title, abstract: abstract,video: pdf , Pdf: video ,bLabel: blabel,image: self.images, TempV: self.tempV , TempP: self.tempP ,EID: self.EID!, cID: self.cid!){
                (flag:Bool) in
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("alertPressedOK", sender:sender)
                }
                
            } }
        
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
            print("In prepare for segue")
            var detailVC = segue!.destinationViewController as! ContentForOrganizerViewController;
            detailVC.ttitle=ETitle.text!
            detailVC.abstract=EAbstract.text!
            detailVC.pdf=EPDF.text!
            detailVC.video=EVideo.text!
            detailVC.contentid=cid!
            detailVC.images=images
            
            
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
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("UpdateImageCell", forIndexPath: indexPath) as! UpdateImageCollectionViewCell
        cell!.cellButton.setImage(images[indexPath.row], forState: UIControlState.Normal)
        cell!.cellButton.tag = i
        cell!.cellButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        imageNum = indexPath.row
        i++
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






