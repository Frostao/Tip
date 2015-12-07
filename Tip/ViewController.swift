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
        tipLabel.text = "$\(total!*percent)"
        totalLabel.text = "$\(total!*(1+percent))"
    }
    
    
    override func viewWillAppear(animated: Bool) {
        totalAmount.becomeFirstResponder()
        percentSelect.selectedSegmentIndex = 2
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
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

