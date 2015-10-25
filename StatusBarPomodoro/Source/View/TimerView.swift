//
//  TimerView.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa

class TimerView: NSView
{
    var clickedHandler: () -> () = {}
    
    var isRunning: Bool = true
    {
        didSet
        {
            self.needsDisplay = true
        }
    }
    
    var timerPercentage: Float = 0.9
    {
        didSet
        {
            self.timerPercentage = max(0.0, min(1.0, self.timerPercentage))
            self.needsDisplay = true
        }
    }
    
    var timerString: String = ""
    {
        didSet
        {
            self.needsDisplay = true
        }
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)

        if let ctx = NSGraphicsContext.currentContext()?.CGContext {
            //CGContextSetFillColor(ctx, [1.0, 1.0, 1.0])
            //CGContextFillRect(ctx, dirtyRect)
            
            let string = (self.timerString as NSString)
            let attrs: [NSObject: AnyObject] = [NSFontAttributeName : NSFont(name: "HelveticaNeue-Light", size:30.0) ?? NSFont.systemFontOfSize(30.0)]
            let stringSize = string.sizeWithAttributes(attrs)
            let stringRect = dirtyRect.rectByCentering(stringSize)
            (self.timerString as NSString).drawInRect(stringRect, withAttributes: attrs)
            
            let arcStartAngle = CGFloat(M_PI) * 2.0 * CGFloat(-1.0 + self.timerPercentage + 0.25)
            let arcEndAngle = CGFloat(M_PI) * 2.0 * CGFloat(0.0 + 0.25)
            let arcWidth = CGFloat(20.0)
            let arcRadius = dirtyRect.width / 2.0 - arcWidth
            let arcStrokeColor = NSColor.grayColor().CGColor
            let arcFillColor = NSColor.lightGrayColor().CGColor
            
            CGContextSaveGState(ctx)
            
            let arcPath = CGPathCreateMutable()
            CGPathAddArc(arcPath, nil, dirtyRect.centerX, dirtyRect.centerY, arcRadius, arcStartAngle, arcEndAngle, true)
            
            let arcStroke = CGPathCreateCopyByStrokingPath(arcPath, nil, arcWidth, kCGLineCapButt, kCGLineJoinMiter, 10)
            
            CGContextAddPath(ctx, arcStroke)
            CGContextSetFillColorWithColor(ctx, arcFillColor)
            CGContextSetStrokeColorWithColor(ctx, arcStrokeColor)
            CGContextDrawPath(ctx, (self.isRunning) ? kCGPathFillStroke : kCGPathStroke)
            
            CGContextRestoreGState(ctx)
        }
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        let clickPoint = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        let inside = NSPointInRect(clickPoint, self.bounds)
        if (inside) {
            self.clickedHandler()
        }
    }
    
}
