//
//  ViewController.swift
//  kidsweb
//
//  Created by taoning on 16/3/11.
//  Copyright © 2016年 taoning. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBAction func launchSFSafariViewController(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "http://baidu.com")!, entersReaderIfAvailable: true)
        svc.delegate = self
        self.presentViewController(svc, animated: true, completion: nil)
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

