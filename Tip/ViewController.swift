//
//  ViewController.swift
//  Tip
//
//  Created by Carl Chen on 12/6/15.
//  Copyright © 2015 Zhen Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalAmount: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountHeight: NSLayoutConstraint!
    
    @IBOutlet weak var percentSelect: UISegmentedControl!
    var fullScreenConstraint:NSLayoutConstraint?
    
    var currentcyType:String = "$"
    
    
    
    @IBAction func valueChanged(sender: AnyObject) {
        if totalAmount.text != "" {
            NSLayoutConstraint.deactivateConstraints([fullScreenConstraint!])
            NSLayoutConstraint.activateConstraints([totalAmountHeight])
            UIView.animateWithDuration(0.5) { () -> Void in
                self.view.layoutIfNeeded()
            }
            calculateTip()
        } else {
            NSLayoutConstraint.deactivateConstraints([totalAmountHeight])
            NSLayoutConstraint.activateConstraints([fullScreenConstraint!])
            UIView.animateWithDuration(0.5) { () -> Void in
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    func setCurrencyType(currentcy: String) {
        currentcyType = currentcy
    }
    
    
    func calculateTip() {
        
        let total = Double(totalAmount.text!)
        var percent:Double = 0
        switch percentSelect.selectedSegmentIndex {
        case 0:
            percent = 0.1
            break
        case 1:
            percent = 0.15
            break
        case 2:
            percent = 0.2
            break
        default:
            break
        }
        tipLabel.text = currentcyType+"\(total!*percent)"
        totalLabel.text = currentcyType+"\(total!*(1+percent))"
        storeTip(total!)
    }
    
    func storeTip(tip:Double) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tip, forKey: "lastTip")
        defaults.setObject(NSDate(), forKey: "lastTime")
        defaults.synchronize()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        totalAmount.becomeFirstResponder()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        //move the text field to the center
        if fullScreenConstraint == nil {
            fullScreenConstraint = NSLayoutConstraint(item: totalAmountHeight.firstItem, attribute: totalAmountHeight.firstAttribute, relatedBy: totalAmountHeight.relation, toItem: totalAmountHeight.secondItem, attribute: totalAmountHeight.secondAttribute, multiplier: 0.8, constant: 0)
            fullScreenConstraint!.priority = totalAmountHeight.priority
            NSLayoutConstraint.deactivateConstraints([totalAmountHeight])
            NSLayoutConstraint.activateConstraints([fullScreenConstraint!])
            self.view.layoutIfNeeded()
        }
    }
    override func viewDidAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        percentSelect.selectedSegmentIndex = 2
        if let percent = defaults.objectForKey("defaultPercent") as? Double {
            switch percent {
            case 0.1:
                percentSelect.selectedSegmentIndex = 0
                break
            case 0.15:
                percentSelect.selectedSegmentIndex = 1
                break
            case 0.2:
                percentSelect.selectedSegmentIndex = 2
                break
            default:
                break
            }
        }
        if let date = defaults.objectForKey("lastTime") as? NSDate {
            let timeDiff = NSDate().timeIntervalSinceDate(date)
            if timeDiff < 600 {
                let lastTip = defaults.objectForKey("lastTip") as! Double
                totalAmount.text = String(lastTip)
                valueChanged(totalAmount)
            }
        }
        
    }
    
    func localeChanged(notification: NSNotification) {
        let currency = notification.object as! String
        currentcyType = currency
        totalAmount.placeholder = currentcyType
        calculateTip()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locale = NSLocale.currentLocale()
        if let currencyType = locale.objectForKey(NSLocaleCurrencyCode) as? String {
            
            if currencyType == "GBP" {
                currentcyType = "£"
            } else {
                currentcyType = "$"
            }
        }
        totalAmount.placeholder = currentcyType
        
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "localeChanged:", name: "localeChanged", object: nil)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

