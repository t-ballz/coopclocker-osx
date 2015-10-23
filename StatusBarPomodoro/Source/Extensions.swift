//
//  Extensions.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

extension NSView
{
    
    func setBorder(width: CGFloat = 1.0, color: NSColor = NSColor.blackColor())
    {
        self.layer?.borderWidth = width
        self.layer?.borderColor = color.CGColor
    }
    
}

// RX helpers

infix operator <~ {}
func <~<T>(variable: Variable<T>, value: T)
{
    variable.next(value)
}

infix operator ~> {}
func ~><T>(signal: Observable<T>, nextBlock:(T) -> ())
{
    signal >- subscribeNext(nextBlock)
}

extension NSButton
{
    func bindToHandler<T>(handler: (NSView) -> Observable<T>) -> Observable<Observable<T>>
    {
        return self.rx_tap >- map { handler(self) }
    }
}
