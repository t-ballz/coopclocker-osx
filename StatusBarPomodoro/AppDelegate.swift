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

    class var instance: AppDelegate {
        return NSApplication.sharedApplication().delegate as! AppDelegate
    }
    
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
            self.statusItemViewModel.imagePosition ~> { button.imagePosition = $0 }
            self.statusItemViewModel.image ~> { button.image = $0 }
            self.statusItemViewModel.imageAlt ~> { button.alternateImage = $0 }
            self.statusItemViewModel.title ~> { button.title = $0 }
            
            button.bindToHandler(self.statusItemViewModel.buttonPressed) >- subscribeNext
            { signal in
                signal >- subscribeCompleted { }
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
