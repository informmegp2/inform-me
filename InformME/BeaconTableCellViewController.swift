//
//  BeaconTableCellViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/6/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
@objc protocol BeaconCellDelegate: class {
    func deleteBeacon(label: String)
    //func updateBeacon()
}
class BeaconTableCellViewController: UITableViewCell {
    var delegate:BeaconCellDelegate?
    var beacon: Beacon = Beacon()
    
    @IBOutlet var name: UILabel!
}