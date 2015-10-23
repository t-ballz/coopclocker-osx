//
//  MainPopupViewController.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa

class MainPopupViewController: NSViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.becomeFirstResponder()
    }
    
}
