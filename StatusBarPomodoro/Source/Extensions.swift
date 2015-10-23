//
//  Extensions.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa
import RxSwift

extension NSView
{
    
    func setBorder(width: CGFloat = 1.0, color: NSColor = NSColor.blackColor())
    {
        self.layer?.borderWidth = width
        self.layer?.borderColor = color.CGColor
    }
    
}

infix operator <~ {}
func <~<T: Any>(variable: Variable<T>, value: T)
{
    variable.next(value)
}

func <~<T: Any>(inout member: T, variable: Variable<T>) -> Disposable
{
    return variable >- subscribeNext { member = $0 }
}

func <~<T: Any>(inout member: T, signal: Observable<T>) -> Disposable
{
    return signal >- subscribeNext { member = $0 }
}
