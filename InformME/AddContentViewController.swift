//
//  BeaconViewController.swift
//  InformME
//
//  Created by sara on 4/24/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var TTitle: UITextField!
    @IBOutlet weak var Abstract: UITextField!
    @IBOutlet weak var Video: UITextField!
    @IBOutlet weak var PDF: UITextField!
    @IBOutlet var FImage: UIButton!
    @IBOutlet var SImage: UIButton!
    @IBOutlet var TImage: UIButton!
    
    @IBOutlet var pickerTextField: UITextField!// for assign
    var cellContent = [String]()
    var images = [UIImage]()
    var numRow:Int?
    var flags = [Bool](count: 4, repeatedValue: false) // for checking the images
    var beaconsInfo: [Beacon] = []//nouf add it for assign beacon
    var beacon:Beacon = Beacon()// for assign beacon
    var UserID = 13
      @IBAction func Submit(sender: AnyObject) {
        var title = TTitle.text!
        var abstract = Abstract.text!
        var video = Video.text!
        var pdf = PDF.text!
        var label=pickerTextField.text
        var c : Content = Content()
      //  c.saveContent(title,abstract: abstract,video: video,Pdf: pdf ,image: FImage.backgroundImageForState(.Normal)!){
        
        //c.saveContent(title,abstract: abstract,video: video,Pdf: pdf ,image: images,flagI: flags){
         //   (flag:Bool) in
        c.createContent(title,abstract: abstract,video: video,Pdf: pdf ,BLabel: label!,image: images,flagI: flags)

            //we should perform all segues in the main thread
           // dispatch_async(dispatch_get_main_queue()) {
        if (c.save){
            self.performSegueWithIdentifier("addContent", sender:sender)
            }
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
    var pickerOne : UIImagePickerController?
    var pickerTwo : UIImagePickerController?
    var pickerThree : UIImagePickerController?

    
    @IBAction func uploadFImage(sender: AnyObject) {
        pickerOne = UIImagePickerController()
        pickerOne!.delegate = self;
        pickerOne!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerOne!, animated: true, completion: nil)
    }
    @IBAction func uploadSImage(sender: AnyObject) {
        
        pickerTwo = UIImagePickerController()
        pickerTwo!.delegate = self;
        pickerTwo!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerTwo!, animated: true, completion: nil)
    }
    
  
    
    @IBAction func uploadTImage(sender: AnyObject) {
         pickerThree = UIImagePickerController()
        pickerThree!.delegate = self;
        pickerThree!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerThree!, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {

         if picker == pickerOne {
        FImage.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
            flags[0]=true
            images.append(FImage.backgroundImageForState(.Normal)!)
        }
        
          else if picker == pickerTwo {
            SImage.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
            flags[1]=true
            images.append(SImage.backgroundImageForState(.Normal)!)

        }
         else if picker == pickerThree {
            TImage.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
            flags[2]=true
            images.append(TImage.backgroundImageForState(.Normal)!)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
    
}
