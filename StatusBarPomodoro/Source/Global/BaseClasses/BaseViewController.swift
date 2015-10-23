//
//  BaseViewController.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa

class BaseViewController: NSViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear()
    {
        super.viewWillAppear()
        Logger.log("ViewController view appear: \(self.dynamicType.description())")
    }
    
}
