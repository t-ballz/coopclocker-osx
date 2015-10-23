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
    
    func statusPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            
            Logger.log("Status indicator pressed.")
            
            return NopDisposable.instance
        }
    }
    
    func settingsPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            
            Logger.log("Settings button pressed.")
            
            return NopDisposable.instance
        }
    }
    
    func popuptogglePressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            
            Logger.log("Popup toggle button pressed.")
            
            return NopDisposable.instance
        }
    }
    
    func restartPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            
            Logger.log("Timer restart button pressed.")
            
            return NopDisposable.instance
        }
    }
    
    func timerPressed(sender: NSView) -> Observable<Void>
    {
        return create
        { sink in
            
            Logger.log("Timer pressed.")
            
            return NopDisposable.instance
        }
    }
    
}
