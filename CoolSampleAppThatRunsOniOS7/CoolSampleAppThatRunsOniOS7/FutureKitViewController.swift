//
//  FutureKitViewController.swift
//  CoolSampleAppThatRunsOniOS7
//
//  Created by Michael Gray on 4/25/15.
//  Copyright (c) 2015 Michael Gray. All rights reserved.
//

import UIKit

class FutureKitViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // this uses both FutureKit AND AlamoFire to grab a file from the internets.
        request(.GET, "https://raw.githubusercontent.com/FutureKit/FutureKit/master/README.md")
            .futureString().onSuccess(.Main) { (result) -> Void in
                self.textView.text = "\(result)"
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
        }
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
