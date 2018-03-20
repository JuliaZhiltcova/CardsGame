//
//  EndOfGameController.swift
//  Cards
//
//  Created by Admin on 07/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class EndOfGameController: UIViewController {

    //var level: Int?
    
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    
    var currentTimeOfLevel: TimeInterval?
    var bestTimeOfLevel: TimeInterval?
    
    @IBAction func goToNextLevelButton(_ sender: UIButton) {
        
       /* if (LevelsManager.currentLevel?.number)! < GameSettings.ElementsPerRowAndColumn.count{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            LevelsManager.currentLevel?.number += 1
            vc.game = Game(level: (LevelsManager.currentLevel?.number)!)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "levelVC") as! LevelViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        } */
        
        if LevelsManager.isItLastLevel(level: LevelsManager.currentLevel!){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "levelVC") as! LevelViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            LevelsManager.goToNextLevelAfter(level: LevelsManager.currentLevel!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            vc.game = Game(level: (LevelsManager.currentLevel?.number)!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let currentTimeOfLevel = currentTimeOfLevel,
            let bestTimeOfLevel = bestTimeOfLevel {
            
            evaluationLabel.text = (currentTimeOfLevel <= bestTimeOfLevel) ?  "Great!" : "Try again"

            
            currentTimeLabel.text = "Время уровня: \(currentTimeOfLevel.textDescription)"
            bestTimeLabel.text = "Лучшее время: \(bestTimeOfLevel.textDescription)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
