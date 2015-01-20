//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Nathan Scharfe on 1/19/15.
//  Copyright (c) 2015 gazer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
   
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        defaultTipControl.selectedSegmentIndex = userDefaults.integerForKey(defaultTipIndexKey)
    }
    
    @IBAction func onDefaultChanged(sender: AnyObject) {
        println(defaultTipControl.selectedSegmentIndex)
        NSUserDefaults.standardUserDefaults().setObject(defaultTipControl.selectedSegmentIndex, forKey: defaultTipIndexKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
