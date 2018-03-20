//
//  TimeIntervalExtantion.swift
//  Cards
//
//  Created by Admin on 19/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension TimeInterval{
    
    var textDescription: String {
    
        //var formattedTime = "00 : 00 : 00"
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
}

//func timeString(time: TimeInterval) -> String {
//    
//    let hours = Int(time) / 3600
//    let minutes = Int(time) / 60 % 60
//    let seconds = Int(time) % 60
//    
//    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
//    
//}
