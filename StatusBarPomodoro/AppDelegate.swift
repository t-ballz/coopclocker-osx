//
//  AppDelegate.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 03/09/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    @IBOutlet weak var window: NSWindow!

    // Due to an XCode bug, these do not link
    // NSVariableStatusItemLength = -1
    // NSSquareStatusItemLength = -2
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let statusItemViewModel = StatusItemViewModel()

    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        self.bindViewModel()
    }

    func applicationWillTerminate(aNotification: NSNotification)
    {
        // Insert code here to tear down your application
    }

    private func bindViewModel()
    {
        if let button = statusItem.button
        {
            button.imagePosition <~ self.statusItemViewModel.imagePosition
            button.image <~ self.statusItemViewModel.image
            button.alternateImage <~ self.statusItemViewModel.imageAlt
            button.title <~ self.statusItemViewModel.title
            button.rx_tap >- map { self.statusItemViewModel.buttonPressed(_sender: button) } >- subscribeNext
            { next in
                next >- subscribeCompleted { }
            }
        }
    }
    
}

class StatusItemViewModel : BaseViewModel
{
    let imagePosition = Variable<NSCellImagePosition>(.ImageLeft)
    let title = Variable<String>("")
    let image = Variable<NSImage?>(nil)
    let imageAlt = Variable<NSImage?>(nil)
    
    private var popOver = NSPopover()
    
    override init()
    {
        super.init()
        
        let image = NSImage(named: "ic_error")
        image?.size = NSMakeSize(20, 20)
        let image2 = NSImage(named: "ic_error_outline")
        image2?.size = NSMakeSize(20, 20)
        
        popOver.contentViewController = MainPopupViewController(nibName: "MainPopupViewController", bundle: nil)
         
        self.title <~ "lolomg"
        self.image <~ image
        self.imageAlt <~ image2
    }
    
    func buttonPressed(_sender: NSView? = nil) -> Observable<String>
    {
        return create
        { sink in
            
            if let sender = _sender
            {
                if (self.popOver.shown)
                {
                    self.popOver.performClose(sender)
                }
                else
                {
                    self.popOver.showRelativeToRect(sender.bounds, ofView: sender, preferredEdge: NSMaxYEdge)
                }
            }
            
            sendCompleted(sink)
            return NopDisposable.instance
        }
    }
    
}
