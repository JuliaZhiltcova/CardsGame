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

    @IBOutlet weak var lezardImageView1: UIImageView!
    @IBOutlet weak var lezardImageView2: UIImageView!
    
    
    @IBOutlet weak var bestTimeLabel: StrokedLabel!
    @IBOutlet weak var currentTimeLabel: StrokedLabel!
    @IBOutlet weak var evaluationLabel: StrokedLabel!
    @IBOutlet weak var goToNextLevelButton: PhantomButton!
    @IBOutlet weak var levelCompleteLabel: StrokedLabel!
    
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
            
            evaluationLabel.strockedText = (currentTimeOfLevel <= bestTimeOfLevel) ?  "Великолепно!" : "Попробуйте еще раз"

            
            currentTimeLabel.strockedText = "Время уровня: \(currentTimeOfLevel.textDescription)"
            bestTimeLabel.strockedText = "Лучшее время: \(bestTimeOfLevel.textDescription)"
        }
        
        levelCompleteLabel.strockedText = "УРОВЕНЬ ОКОНЧЕН"
        lezardImageView2.transform = CGAffineTransform(scaleX: -1, y: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        levelCompleteLabel.translatesAutoresizingMaskIntoConstraints = false
        levelCompleteLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        levelCompleteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true

        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
          levelCompleteLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
            
        case .phone:
           levelCompleteLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        default: break;
        }
       
        evaluationLabel.translatesAutoresizingMaskIntoConstraints = false
        evaluationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        evaluationLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: self.view.bounds.height/4).isActive = true
        evaluationLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true

        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            evaluationLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
        case .phone:
            evaluationLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        default: break;
        }
        
        
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        currentTimeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        bestTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        bestTimeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        bestTimeLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        bestTimeLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            bestTimeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true
            
        case .phone:
            bestTimeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 25).isActive = true
        default: break;
        }
        
        goToNextLevelButton.translatesAutoresizingMaskIntoConstraints = false
        goToNextLevelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        goToNextLevelButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.bounds.height/7).isActive = true
        goToNextLevelButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        goToNextLevelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let lezardImageViewHeight = self.view.bounds.height * 0.8
        var lezardImageViewWidth: CGFloat!
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            lezardImageViewWidth = self.view.bounds.width * 0.25
        case .phone:
            lezardImageViewWidth = self.view.bounds.width * 0.2
        default: break;
        }
        lezardImageView1.translatesAutoresizingMaskIntoConstraints = false
        lezardImageView1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        lezardImageView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        lezardImageView1.heightAnchor.constraint(equalToConstant: lezardImageViewHeight).isActive = true
        lezardImageView1.widthAnchor.constraint(equalToConstant: lezardImageViewWidth).isActive = true
        
        lezardImageView2.translatesAutoresizingMaskIntoConstraints = false
        lezardImageView2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        lezardImageView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        lezardImageView2.heightAnchor.constraint(equalToConstant: lezardImageViewHeight).isActive = true
        lezardImageView2.widthAnchor.constraint(equalToConstant: lezardImageViewWidth).isActive = true
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
