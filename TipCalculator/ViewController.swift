//
//  ViewController.swift
//  TipCalculator
//
//  Created by Nathan Scharfe on 1/19/15.
//  Copyright (c) 2015 gazer. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let tipPercentages = [0.18, 0.20, 0.22]
    let tenMinutes = NSTimeInterval(60 * 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If we have a cached bill that is less than 10 minutes old,
        // load it. Otherwise leave the bill text field empty
        let cachedBill = userDefaults.dictionaryForKey(cachedBillKey)
        if cachedBill != nil {
            let cachedBillDict = cachedBill as Dictionary!
            if NSDate().timeIntervalSinceDate(cachedBillDict["date"] as NSDate) < tenMinutes {
                billField.text = cachedBillDict["bill"] as String
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = userDefaults.integerForKey(defaultTipIndexKey)
        onEditingChanged(tipControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let billAmount = (billField.text as NSString).doubleValue
        let tipAmount = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        
        // Cache last bill to NSUserDefaults every time the user updates the bill value
        let billToCache = ["bill": billField.text, "date": NSDate()]
        NSUserDefaults.standardUserDefaults().setObject(billToCache, forKey: cachedBillKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", tipAmount + billAmount)
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}