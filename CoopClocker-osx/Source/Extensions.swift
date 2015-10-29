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

extension NSDate
{
    func minutes_seconds() -> (Int, Int)
    {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitMinute | .CalendarUnitSecond, fromDate: self)
        return (components.minute, components.second)
    }
}

// RX helpers

extension Observable
{
    class func rx_return<T>(value: T) -> Observable<T>
    {
        return create { sink in
            sendNext(sink, value)
            sendCompleted(sink)
            
            return NopDisposable.instance
        }
    }
}

infix operator <~ {}
func <~<T>(variable: Variable<T>, value: T)
{
    variable.next(value)
}

func <~<T>(variable: Variable<T>, signal: Observable<T>) -> Disposable
{
    return signal.subscribe(variable)
}

infix operator ~> {}
func ~><T>(signal: Observable<T>, nextBlock:(T) -> ())
{
    signal >- subscribeNext(nextBlock)
}

infix operator *~> {}
func *~><T>(signal: Observable<T>, completedBlock: () -> ())
{
    signal >- subscribeCompleted(completedBlock)
}

extension NSButton
{
    func bindToHandler<T>(handler: (NSView) -> Observable<T>) -> Observable<Observable<T>>
    {
        return self.rx_tap >- map { handler(self) }
    }
}
