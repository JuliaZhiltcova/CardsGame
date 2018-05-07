//
//  Level.swift
//  Cards
//
//  Created by Admin on 04/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Level: NSObject, NSCoding {

    var number: Int
    var image: UIImage
    var bestTime: TimeInterval? //TimeInterval     // in seconds
    var isLocked: Bool
    
    let levelImageNames: [Int: String] = [
        1: "l1",
        2: "l2",
        3: "l3",
        4: "l4",
        5: "l5",
        6: "l6",
        7: "l7",
        8: "l8",
        9: "l9",
        10: "l10"
    ]
    
    init(number: Int, bestTime: TimeInterval? = nil, isLocked: Bool = true) {
        self.number = number
        self.image = UIImage(named: levelImageNames[number]!)!
        self.bestTime = bestTime
        self.isLocked = isLocked
    }
    
    required  convenience init?(coder decoder: NSCoder) {
        let number = decoder.decodeInt64(forKey: "number")
        let bestTime = decoder.decodeObject(forKey: "bestTime") as? TimeInterval
        let isLocked = decoder.decodeBool(forKey: "isLocked")

        
        self.init(
            number: Int(number),
            bestTime: bestTime,
            isLocked: Bool(isLocked)
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.number, forKey: "number")
        coder.encode(self.bestTime, forKey: "bestTime")
        coder.encode(self.isLocked, forKey: "isLocked")
    }
    
    lazy var currentGame: Game = Game(level: self.number)
    
   // static var currentLevel: Level?
    
//
//    
//    private var currentGame_: Game?
//    
//    static func initGame(типИгры:Int, левел:Int) {
//        //
//        
//        var theCosOfZero: Double = Double(cos(0))  // theCosOfZero equals 1
//    }
//    
//    var currentGame: Game? {
//        get {
//            return currentGame_
//        }
//    }

}

