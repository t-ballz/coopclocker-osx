//
//  MainPopupViewController.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class MainPopupViewController: BaseViewController
{
    var mainPopupViewModel: MainPopupViewModel = MainPopupViewModel()
    override var viewModel: MainPopupViewModel
    {
        get { return self.mainPopupViewModel }
    }
    
    @IBOutlet weak var settingsButton: NSButton!
    @IBOutlet weak var networkButton: NSButton!
    @IBOutlet weak var newTaskButton: NSButton!
    @IBOutlet weak var popupButton: NSButton!

    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var servernameLabel: NSTextField!
    @IBOutlet weak var organizationLabel: NSTextField!
    @IBOutlet weak var projectLabel: NSTextField!
    @IBOutlet weak var taskLabel: NSTextField!
    @IBOutlet weak var timerLabel: NSTextField!
    
    @IBOutlet weak var taskTableView: NSScrollView!
    @IBOutlet weak var timerView: TimerView!
    
    
    override func bindViewModel()
    {
        self.usernameLabel.stringValue <~ self.viewModel.userName
        self.servernameLabel.stringValue <~ self.viewModel.serverName
        self.organizationLabel.stringValue <~ self.viewModel.organizationName
        self.projectLabel.stringValue <~ self.viewModel.projectName
        self.taskLabel.stringValue <~ self.viewModel.taskName
        self.timerLabel.stringValue <~ combineLatest(self.viewModel.timerMinues, self.viewModel.timerSeconds) { minutes, seconds in String(format: "%02d:%02d", minutes, seconds) }
        
        settingsButton.bindToHandler(self.viewModel.settingsPressed) >- subscribeNext
        { signal in
            signal >- subscribeCompleted {}
        }
        
        self.networkButton.bindToHandler(self.viewModel.networkPressed) >- subscribeNext
        { signal in
            signal >- subscribeCompleted {}
        }
        
        self.newTaskButton.bindToHandler(self.viewModel.newTaskPressed) >- subscribeNext
        { signal in
            signal >- subscribeCompleted {}
        }
        
        self.popupButton.bindToHandler(self.viewModel.popupPressed) >- subscribeNext
        { signal in
            signal >- subscribeCompleted {}
        }
        
        self.timerView.clickedHandler =
        {
            self.viewModel.timerPressed(self.timerView) >- subscribeCompleted {}
        }
        
    }
    
}
