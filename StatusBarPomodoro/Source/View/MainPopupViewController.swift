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
    
    @IBOutlet weak var taskTableView: NSScrollView!
    @IBOutlet weak var timerView: TimerView!
    
    override func bindViewModel()
    {
        let timerStringSignal = combineLatest(self.viewModel.timerMinutes, self.viewModel.timerSeconds) { minutes, seconds in String(format: "%02d:%02d", minutes, seconds) }
        
        self.viewModel.userName ~> { self.usernameLabel.stringValue = $0 }
        self.viewModel.serverName ~> { self.servernameLabel.stringValue = $0 }
        self.viewModel.organizationName ~> { self.organizationLabel.stringValue = $0 }
        self.viewModel.projectName ~> { self.projectLabel.stringValue = $0 }
        self.viewModel.taskName ~> { self.taskLabel.stringValue = $0 }
        timerStringSignal ~> { self.timerView.timerString = $0 }
        self.viewModel.timerRunning ~> { self.timerView.isRunning = $0 }
        
        settingsButton.bindToHandler(self.viewModel.settingsPressed) ~>
        { signal in
            signal *~> {}
        }
        
        self.networkButton.bindToHandler(self.viewModel.networkPressed) ~>
        { signal in
            signal *~> {}
        }
        
        self.newTaskButton.bindToHandler(self.viewModel.newTaskPressed) ~>
        { signal in
            signal *~> {}
        }
        
        self.popupButton.bindToHandler(self.viewModel.popupPressed) ~>
        { signal in
            signal *~> {}
        }
        
        self.timerView.clickedHandler =
        {
            self.viewModel.timerPressed(self.timerView) *~> {}
        }
        
    }
    
}
