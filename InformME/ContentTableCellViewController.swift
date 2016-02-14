//
//  ContentTableCellViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ContentCellDelegate: class {

}
class ContentTableCellViewController: UITableViewCell {
    var delegate:ContentCellDelegate?
    var content: Content = Content()
    
    @IBOutlet var title: UILabel!
    
}