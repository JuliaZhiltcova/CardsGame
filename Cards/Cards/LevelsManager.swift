//
//  LevelManager.swift
//  Cards
//
//  Created by Admin on 15/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation


class LevelsManager{

    static var levels = [Level]()
    static var currentLevel: Level?
    
    init(){
        
        if let data = UserDefaults.standard.data(forKey: "levels"),
            let levels_ = NSKeyedUnarchiver.unarchiveObject(with: data) as? Array<Level> {
            
            LevelsManager.levels = levels_
            
        } else {
            
            for number in 0..<GameSettings.ElementsPerRowAndColumn.count {
                let level = Level(number: number + 1)
                LevelsManager.levels.append(level)
            }
        }
    }
 
    class func isItLastLevel(level: Level) -> Bool{
        return level == levels.last
    }
    
    class func goToNextLevelAfter(level: Level) {
        let indexOfLevel = levels.index(of: level)
        self.currentLevel = levels[levels.index(after: indexOfLevel!)]
    }
}







/*
 
 if let data = UserDefaults.standard.data(forKey: "levels"),
 let levels_ = NSKeyedUnarchiver.unarchiveObject(with: data) as? Array<Level> {
 
 LevelManager.levels = levels_
 
 // levels = rootDict["levels"]!
 
 //            levelsList.forEach { level in
 //                levels.append(Level(number: level.number + 1, bestTime: level.bestTime))
 //            }
 } else {
 
 for number in 0..<GameSettings.ElementsPerRowAndColumn.count {
 let level = Level(number: number + 1)
 levels.append(level)
 }
 }
 
 }
 
 */
