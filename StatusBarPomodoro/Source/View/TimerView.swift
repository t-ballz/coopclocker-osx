//
//  TimerView.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa

class TimerView: NSView {
    var clickedHandler: () -> () = {}

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        self.clickedHandler()
    }
    
}
