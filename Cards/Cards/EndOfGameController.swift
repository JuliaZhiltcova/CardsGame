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
    
    var currentTimeOfLevel: Int = 0
    @IBOutlet weak var bestTimeLabel: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    
    @IBAction func goToNextLevelButton(_ sender: UIButton) {
        
        if Level.currentLevel < GameSettings.ElementsPerRowAndColumn.count{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            Level.currentLevel += 1
            vc.game = Game(level: Level.currentLevel)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "levelVC") as! LevelViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
