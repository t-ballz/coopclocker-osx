//
//  MainPopupViewModel.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa
import RxSwift

class MainPopupViewModel : BaseViewModel
{
    
    class WorkListEntry
    {
        // TODO
    }
    
    enum OperationStatus
    {
        case Ok, Pending, Error
    }
    
    enum OperationMode
    {
        case Offline, Online, Pending
    }
    
    let operationStatus = Variable<OperationStatus>(.Pending)
    let operationMode = Variable<OperationMode>(.Pending)
    
    let userName = Variable<String>("Unknown user")
    let serverName = Variable<String>("No server")
    
    let organizationName = Variable<String>("Unnamed organization")
    let projectName = Variable<String>("Unnamed project")
    let taskName = Variable<String>("No task")
    
    let timerRunning = Variable<Bool>(false)
    let timerProgress = Variable<Float>(0.0)
    let timerMinutes = Variable<Int>(0)
    let timerSeconds = Variable<Int>(0)
    
    
    let popupEnabled = Variable<Bool>(true)
    
    private let disposeBag = DisposeBag()
    
    override init()
    {
        super.init()
        
        let timerDispose = interval(1.0, MainScheduler.sharedInstance) >-
            flatMap { next in Observable<NSDate>.rx_return(NSDate()) } >-
            subscribeNext { next in
                let (minutes, seconds) = next.minutes_seconds()
                self.timerMinutes <~ minutes
                self.timerSeconds <~ seconds
            }
        self.disposeBag.addDisposable(timerDispose)
    }
    
    func networkPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            Logger.log("Status indicator pressed.")
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
    func settingsPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            Logger.log("Settings button pressed.")
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
    func popupPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            Logger.log("Popup toggle button pressed.")
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
    func newTaskPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            Logger.log("Timer restart button pressed.")
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
    func timerPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            Logger.log("Timer pressed.")
            
            self.timerRunning <~ !self.timerRunning.value
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
}
