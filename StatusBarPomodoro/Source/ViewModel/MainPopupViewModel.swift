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
    
    let userName = Variable<String>("unknown")
    let serverName = Variable<String>("No server")
    
    let organizationName = Variable<String>("Unnamed organization")
    let projectName = Variable<String>("Unnamed project")
    let taskName = Variable<String>("No task")
    
    let timeProgress = Variable<Float>(0.0)
    let timerMinues = Variable<Int>(0)
    let timerSeconds = Variable<Int>(0)
    
    let popupEnabled = Variable<Bool>(true)
    
    override init()
    {
        super.init()
    }
    
    func networkPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            
            self.userName <~ "pressed"
            
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
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
}
