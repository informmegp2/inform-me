//
//  BeaconViewController.swift
//  InformME
//
//  Created by sara on 4/24/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage]=[]
    
    
    @IBOutlet weak var TTitle: UITextField!
    @IBOutlet weak var Abstract: UITextField!
    @IBOutlet weak var Video: UITextField!
    @IBOutlet weak var PDF: UITextField!
    
    @IBOutlet var pickerTextField: UITextField!// for assign
    var cellContent = [String]()
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
    var beaconsInfo: [Beacon] = []//nouf add it for assign beacon
    var beacon:Beacon = Beacon()// for assign beacon
    var EID : Int?
    @IBAction func Submit(sender: AnyObject) {
        var title = TTitle.text!
        var abstract = Abstract.text!
        var video = Video.text!
        var pdf = PDF.text!
        var label=pickerTextField.text
        
        var c : Content = Content()
        
        c.createContent(title,abstract: abstract,video: video,Pdf: pdf ,BLabel: label!,EID: EID! ,image: images ){
            (flag:Bool) in
            //we should perform all segues in the main thread
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("addContent", sender:sender)
            }
        } }
    
    
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
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        TTitle.delegate = self
        Abstract.delegate = self
        Video.delegate = self
        PDF.delegate = self
        
    }
    
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
    
    //------ for images
    var image : UIImage?
    
    @IBAction func addImage(sender: AnyObject) {
        let pickerOne = UIImagePickerController()
        pickerOne.delegate = self;
        pickerOne.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerOne, animated: true, completion: nil)
    }
    
    
    @IBOutlet var add: UIButton!
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        images.append((info[UIImagePickerControllerOriginalImage]as? UIImage)!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        collectionView.reloadData()
        if images.count == 3 {
            add.hidden = true
        }
    }
    
    // *** for keyboard
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
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UpdateImageCell", forIndexPath: indexPath) as! UpdateImageCollectionViewCell
        cell.cellButton.setImage(images[indexPath.row], forState: UIControlState.Normal)
        return cell
    }
    
    
}
