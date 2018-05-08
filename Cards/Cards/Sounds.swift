//
//  Sounds.swift
//  Cards
//
//  Created by Admin on 08/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import AVFoundation

class Sounds {
 
    //  для свойств хранения - static, а для вычисляемых - class
    static var backGroundPlayer = AVAudioPlayer()
    private static var isPlaying = false
    
  /*  class var completeLevelSound: SystemSoundID {
        get {
            var soundID: SystemSoundID = 0
            let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "Sound" as CFString!, "mp3" as CFString!, nil)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            return soundID
        }
    } */

    
    static var completeLevelSound: SystemSoundID = createCompleteLevelSoundID()
    
    class func createCompleteLevelSoundID() -> SystemSoundID{
        var soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "Sound" as CFString!, "mp3" as CFString!, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        return soundID
    }
  
    class func disposeSystemSoundID(systemSoundID: SystemSoundID){
        AudioServicesDisposeSystemSoundID(systemSoundID)
    }

    class func playBackGroundMusic(fileNamed: String){
        isPlaying = true
        let url = Bundle.main.url(forResource: fileNamed, withExtension: nil)
        guard let newUrl = url else {
            print("Could not find file named \(fileNamed)")
            return
        }
        
        do {
            Sounds.backGroundPlayer  = try AVAudioPlayer(contentsOf: newUrl)
            Sounds.backGroundPlayer.numberOfLoops = -1
            Sounds.backGroundPlayer.prepareToPlay()
            Sounds.backGroundPlayer.play()
           
        }
        catch let error as NSError{
            print(error.description)
        }
    }
    
    class func pauseContinuePlaying(){
        if Sounds.isPlaying {
            Sounds.backGroundPlayer.pause()
            Sounds.disposeSystemSoundID(systemSoundID: completeLevelSound)
            Sounds.isPlaying = false
        } else {
            Sounds.backGroundPlayer.play()
            completeLevelSound = createCompleteLevelSoundID()
            Sounds.isPlaying = true
        }
    }
    


}
