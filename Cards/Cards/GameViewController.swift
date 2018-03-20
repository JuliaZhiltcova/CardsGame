//
//  ViewController.swift
//  Cards
//
//  Created by Admin on 29/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!

    
    var timer = Timer()
    var isTimerRunning = false
    private var startHintTime: Date?
    private var endHintTime: Date?
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var gameContentView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBOutlet var menuView: UIView!
    @IBOutlet var addTimeView: UIView!
    
    
    
    var effect: UIVisualEffect!
    let reuseIdentifier = "cardCell"
    
    var game: Game!
    var layout: CenterAlignedCollectionViewFlowLayout?
    
    
    @IBAction func backToLevelsButton(_ sender: UIButton) {
      
      
           game.finishGame()
         //  let levelVC = self.storyboard?.instantiateViewController(withIdentifier: "levelVC") as! LevelViewController
         //  self.navigationController?.pushViewController(levelVC, animated: true)
       
       
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        for aViewController in viewControllers {
            if aViewController is LevelViewController {
                _ = self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
       
        
        
        /*
        if let nc = self.navigationController {
            nc.popViewController(animated: true)
        }*/
        
       }
    
    @IBAction func backToGameButton(_ sender: UIButton) {
        runTimer()
        animateOut()
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        game.finishGame()
        game.startNewGame()
        animateOut()
    }


    @IBAction func hintButton(_ sender: UIButton) {
        timer.invalidate()
        startHintTime = Date()
        flipOverAllHiddenCards(isPenalty: true)
    }
    
    
    @IBAction func menuButton(_ sender: UIButton) {
        timer.invalidate()
        animateIn()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        game.delegate = self
        
        cardsCollectionView.backgroundColor = UIColor.green
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
       
        layout = cardsCollectionView.collectionViewLayout as? CenterAlignedCollectionViewFlowLayout
        //layout?.level = game.level
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layout?.boundWidth = self.view.bounds.width
        layout?.boundHeight = self.view.bounds.height
        
        game.startNewGame()
    }

    override func viewDidAppear(_ animated: Bool) {
        flipOverAllHiddenCards(isPenalty: false)
    }
    
    override func viewWillLayoutSubviews() {
        cardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (layout?.widthConstant)!)
        
        let heightConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (layout?.heightConstant)!)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        cardsCollectionView.backgroundColor = UIColor.green
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    func cardForIndexPath(indexPath: IndexPath) -> Card {
        //return cards[(indexPath as NSIndexPath).section].[(indexPath as IndexPath).row]
        let row = (indexPath as IndexPath).row
        return game.cards[row]
    }
    
    func cellForIndexPath(indexPath: IndexPath) -> CardViewCell {
        return cardsCollectionView.cellForItem(at: indexPath) as! CardViewCell
    }

    
    func flipOverAllHiddenCards(isPenalty addTime: Bool, completion: (() -> ())? = nil) {
        
    
        let faceDownCards = getFaceDownCards()
        cardsCollectionView.isUserInteractionEnabled = false
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                if addTime {
                    self.animateAddTimeView()
//                    self.endHintTime = Date()
//                    let hintTimeInterval = self.endHintTime!.timeIntervalSince(self.startHintTime!)
//                    self.game.startGameTime = self.game.startGameTime?.addingTimeInterval(-30 + hintTimeInterval)
//                    self.timerLabel.text = self.game.elapsedTime?.textDescription
//                    self.runTimer()
                }
                else {
                    self.game.startGameTime = Date.init()
                    self.runTimer()
                }
                self.cardsCollectionView.isUserInteractionEnabled = true
            })
            
            faceDownCards.forEach { cell in
                cell.prepareFlipToBackAnimation()
            }
            
            CATransaction.commit()
            
        })
        
        faceDownCards.forEach { cell in
            cell.prepareFlipToFaceAnimation()
        }
        
        
        CATransaction.commit()
     
    }
    
    func getFaceDownCards() -> [CardViewCell]{
        var faceDownCards = [CardViewCell]()
        for (index, card) in game.cards.enumerated() where card.isFaceUp == false {
            let cell = cardsCollectionView.cellForItem(at: [0, index]) as! CardViewCell
            faceDownCards.append(cell)
        }
        return faceDownCards
    }

    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer(){
        timerLabel.text = game.elapsedTime?.textDescription
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        if let endOfGameController = destinationViewController as? EndOfGameController,
            segue.identifier == "showEndOfGameController"{
            endOfGameController.currentTimeOfLevel = game.elapsedTime
        }
    }
    
    func animateAddTimeView(){
        self.view.addSubview(addTimeView)
        addTimeView.center = timerLabel.center
        
        addTimeView.transform =  CGAffineTransform(scaleX: 0.5, y: 0.5)    //.identity


        UIView.animate(withDuration: 3.0, animations: {
            self.addTimeView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { success in
            UIView.animate(withDuration: 1.0, animations: {
                self.endHintTime = Date()
                let hintTimeInterval = self.endHintTime!.timeIntervalSince(self.startHintTime!)
                self.game.startGameTime = self.game.startGameTime?.addingTimeInterval(-30 + hintTimeInterval)
                self.timerLabel.text = self.game.elapsedTime?.textDescription
                self.runTimer()
                self.addTimeView.removeFromSuperview()
            })
            
        }
    }
}


extension GameViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CardViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CardViewCell
        let card = game.cards[indexPath.row]
        
        cell.cardImageView.image = UIImage(named: card.name)
        cell.bringBackToFace()

        return cell
    }
}

extension GameViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = cardForIndexPath(indexPath: indexPath)
        game.didSelectCard(card)
    }
}

extension GameViewController: CardsGame {
    
    func flip(_ cardIndices: [Int], toFace direction: Bool){
        for item in cardIndices {
            let indexPath = IndexPath(row: item, section: 0)
            let cell = cellForIndexPath(indexPath: indexPath)
            cell.flipCard(flipToFace: direction)
        }
    }
    
    func gameDidStart() {
        cardsCollectionView.reloadData()
        timer.invalidate()
        game.startGameTime = nil
        timerLabel.text = "00 : 00 : 00"
    }
    
    func gameDidEnd(){
        timer.invalidate()
       // guard game.elapsedTime != nil else { return }
        game.endGameTime = game.elapsedTime
    }
  
    
    func goToNextLevel(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "endOfGameVC") as! EndOfGameController
            
            if LevelsManager.currentLevel?.bestTime == nil {        // first time game
                LevelsManager.currentLevel?.bestTime = self.game.endGameTime //self.seconds
                
            } else {
                
                if self.game.endGameTime! <= (LevelsManager.currentLevel?.bestTime)! {
                    LevelsManager.currentLevel?.bestTime = self.game.endGameTime
                }
            }
            
            vc.currentTimeOfLevel = self.game.endGameTime
            vc.bestTimeOfLevel = LevelsManager.currentLevel?.bestTime
            
            
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: LevelsManager.levels)
            UserDefaults.standard.set(encodedData, forKey: "levels")
            UserDefaults.standard.synchronize()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
}

extension GameViewController {

    func animateIn(){
        self.view.bringSubview(toFront: visualEffectView)
        self.view.addSubview(menuView)
        menuView.center = self.view.center
        menuView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.menuView.alpha = 1.0
        }
    }
    
    func animateOut(){
        self.view.sendSubview(toBack: visualEffectView)
        UIView.animate(withDuration: 0.2, animations: {
            
            self.menuView.alpha = 0
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.menuView.removeFromSuperview()
            self.flipOverAllHiddenCards(isPenalty: false)
        }
    }
}



//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.landscapeRight
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        return UIInterfaceOrientation.landscapeRight
//    }


/*
func flipOverAllHiddenCards(){
    for (index, card) in game.cards.enumerated() where card.isFaceUp == false {
        // let visible = cardsCollectionView.indexPathsForVisibleItems
        // print(visible)
        //let cell = cardsCollectionView.cellForItem(at: [0, index]) as! CardViewCell
        let cell = cells[index]
        cell.flipOver()
    }
}
 
 
 
 func flipOverAllHiddenCards(){
 for (index, card) in game.cards.enumerated() where card.isFaceUp == false {
 let cell = cells[index]
 //cell.flipOver()
 cell.flipCard(flipToFace: true)
 cell.flipCard(flipToFace: false)
 }
 }
 */


