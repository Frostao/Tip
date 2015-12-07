//
//  SettingsViewController.swift
//  Tip
//
//  Created by Carl Chen on 12/7/15.
//  Copyright © 2015 Zhen Chen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var pencentageSelector: UISegmentedControl!

    @IBAction func valueChanged(sender: AnyObject) {
        var percent:Double = 0
        switch pencentageSelector.selectedSegmentIndex {
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
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(percent, forKey: "defaultPercent")
        defaults.synchronize()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let percent = defaults.objectForKey("defaultPercent") as? Double {
            switch percent {
            case 0.1:
                pencentageSelector.selectedSegmentIndex = 0
                break
            case 0.15:
                pencentageSelector.selectedSegmentIndex = 1
                break
            case 0.2:
                pencentageSelector.selectedSegmentIndex = 2
                break
            default:
                break
            }
        }        // Do any additional setup after loading the view.
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

}
