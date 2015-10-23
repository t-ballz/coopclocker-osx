//
//  Logger.swift
//  StatusBarPomodoro
//
//  Created by TaileS Ballz on 23/10/15.
//  Copyright (c) 2015 ballz. All rights reserved.
//

import Cocoa

class Logger
{
    private static func _log(message:String, file: String = "", line: Int = 0)
    {
        var header:String = ""
        
        header = file + "(\(line)): " + " | " + header
        
        let logMessage = header + "\n" + message + "\n"
        
        NSLog(logMessage)
    }
    
    static func log(message:String, file: String = __FILE__, line: Int = __LINE__) {
        Logger._log(message, file: file, line: line)
    }
}
