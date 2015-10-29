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
    var viewModel: BaseViewModel
    {
        get { MUSTOVERRIDE(); return BaseViewModel() }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.bindViewModel()
    }
    
    override func viewWillAppear()
    {
        super.viewWillAppear()
        Logger.log("ViewController view appear: \(self.dynamicType.description())")
    }
    
    func bindViewModel()
    {
        MUSTOVERRIDE()
    }
    
}
