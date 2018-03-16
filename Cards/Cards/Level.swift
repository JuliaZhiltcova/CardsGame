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
    var bestTime: Int? //TimeInterval     // in seconds
    
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
    
    init(number: Int, bestTime: Int? = nil) {
        self.number = number
        self.image = UIImage(named: levelImageNames[number]!)!
        self.bestTime = bestTime
    }
    
    required  convenience init?(coder decoder: NSCoder) {
        let number = decoder.decodeInt64(forKey: "number")
        let bestTime = decoder.decodeObject(forKey: "bestTime") as? Int

        
        self.init(
            number: Int(number),
            bestTime: bestTime 
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.number, forKey: "number")
        coder.encode(self.bestTime, forKey: "bestTime")
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

