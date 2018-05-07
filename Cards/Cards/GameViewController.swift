//
//  ViewController.swift
//  Cards
//
//  Created by Admin on 29/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: StrokedLabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var menuButton: PhantomButton!

    @IBOutlet weak var addTimeImage: UIImageView!
    
    var timer = Timer()
    var isTimerRunning = false
    private var startHintTime: Date?
    private var endHintTime: Date?
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var gameContentView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBOutlet var menuView: UIView!
    @IBOutlet var addTimeView: UIView!
    
    @IBOutlet weak var backToGameButton: StrokedTextButton!
    @IBOutlet weak var playAgainButton: StrokedTextButton!
    @IBOutlet weak var quitButton: StrokedTextButton!
    @IBOutlet weak var soundButton: StrokedTextButton!
    
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
        endHintTime = Date()
        let hintTimeInterval = self.endHintTime!.timeIntervalSince(self.startHintTime!)
        game.startGameTime = self.game.startGameTime?.addingTimeInterval(hintTimeInterval)
        timerLabel.strockedText = self.game.elapsedTime?.textDescription as! String
    
        runTimer()
        animateOut(playAgain: false)
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        game.finishGame()
        game.startNewGame()
        animateOut(playAgain: true)
    }


    @IBAction func hintButton(_ sender: UIButton) {
        timer.invalidate()
        startHintTime = Date()
        hintButton.isEnabled = false
        flipOverAllHiddenCards(isPenalty: true)
    }
    
    
    @IBAction func menuButton(_ sender: UIButton) {
        timer.invalidate()
        startHintTime = Date()
        animateIn()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        game.delegate = self
        
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
       
        layout = cardsCollectionView.collectionViewLayout as? CenterAlignedCollectionViewFlowLayout
        

        //menuButton.setCustomAttributedTitle(title: "Меню", fontSize: 30)
        //layout?.level = game.level
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layout?.boundWidth = self.view.bounds.width
        layout?.boundHeight = self.view.bounds.height
        
        cardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cardsCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        cardsCollectionView.widthAnchor.constraint(equalToConstant: (layout?.widthConstant)!).isActive = true
        cardsCollectionView.heightAnchor.constraint(equalToConstant: (layout?.heightConstant)!).isActive = true
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: cardsCollectionView.centerXAnchor, constant: 0).isActive = true
        let yOffset = self.view.bounds.height/12
        timerLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: yOffset).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        view.layoutIfNeeded()
        
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor, constant: 0).isActive = true
        let xOffset: CGFloat = (self.view.bounds.maxX - (self.view.bounds.midX + timerLabel.bounds.midX)) / 2
        menuButton.centerXAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: xOffset).isActive = true
        
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            menuButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
            menuButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        case .phone:
            menuButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
            menuButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        default: break;
        }
        
        hintButton.translatesAutoresizingMaskIntoConstraints = false
        hintButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor, constant: 0).isActive = true
        hintButton.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: xOffset).isActive = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            hintButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
            hintButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        case .phone:
            hintButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
            hintButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        default: break;
        }
        
        game.startNewGame()
    }

    override func viewDidAppear(_ animated: Bool) {
        flipOverAllHiddenCards(isPenalty: false)
    }
    
    override func viewWillLayoutSubviews() {
        //отсюда перенесены ограничения

        
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
                self.hintButton.isEnabled = true
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
        timerLabel.strockedText = game.elapsedTime?.textDescription as! String
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
        addTimeView.center = CGPoint(x: timerLabel.center.x + timerLabel.frame.width/2 + 20, y: timerLabel.center.y)
        
        let text: NSString = "+30"
        let newImage = textToImage(text: text, atPoint: CGPoint(x: 0, y: 0))
        addTimeImage.image = newImage

        addTimeView.transform =  CGAffineTransform(scaleX: 0.5, y: 0.5)    //.identity


        UIView.animate(withDuration: 3.0, animations: {
            self.addTimeView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { success in
            UIView.animate(withDuration: 1.0, animations: {
                self.endHintTime = Date()
                let hintTimeInterval = self.endHintTime!.timeIntervalSince(self.startHintTime!)
                self.game.startGameTime = self.game.startGameTime?.addingTimeInterval(-30 + hintTimeInterval)
                self.timerLabel.strockedText = self.game.elapsedTime?.textDescription as! String
                self.runTimer()
                self.addTimeView.removeFromSuperview()
                self.hintButton.isEnabled = true
            })
            
        }
    }
    
    func textToImage(text: NSString, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "EjaRoundFilled", size: 40)
        let scale = UIScreen.main.scale
        let backgroundColor = UIColor.clear

        let addViewImageSize = CGSize(width: 138, height: 40)
        UIGraphicsBeginImageContextWithOptions(addViewImageSize, false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
            NSBackgroundColorAttributeName: backgroundColor
            ] as [String: Any]

        let rect = CGRect(origin: point, size: addViewImageSize)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        
        return newImage!
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
        hintButton.isEnabled = false
        game.startGameTime = nil
        timerLabel.strockedText = "00 : 00 : 00"
    }
    
    func gameDidEnd(){
        timer.invalidate()
        hintButton.isEnabled = false
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
        

        menuView.frame.size = CGSize(width: view.bounds.width*0.5, height: view.bounds.height*0.5)
        self.view.addSubview(menuView)
        menuView.center = self.view.center
    
//        backToGameButton.setCustomAttributedTitle(title: "Назад в игру", fontSize: 50)
//        playAgainButton.setCustomAttributedTitle(title: "Сыграть заново", fontSize: 50)
//        quitButton.setCustomAttributedTitle(title: "Выход", fontSize: 50)
//        soundButton.setCustomAttributedTitle(title: "Звук", fontSize: 50)
        
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:

            backToGameButton.setCustomAttributedTitle(title: NSLocalizedString("Back to game", comment: "Back to game"), fontSize: 50)
            playAgainButton.setCustomAttributedTitle(title: NSLocalizedString("Restart", comment: "Play again"), fontSize: 50)
            quitButton.setCustomAttributedTitle(title: NSLocalizedString("Exit", comment: "Quit"), fontSize: 50)
            soundButton.setCustomAttributedTitle(title: NSLocalizedString("Sound", comment: "Sound"), fontSize: 50)
        case .phone:

            backToGameButton.setCustomAttributedTitle(title: NSLocalizedString("Back to game", comment: "Back to game"), fontSize: 30)
            playAgainButton.setCustomAttributedTitle(title: NSLocalizedString("Restart", comment: "Play again"), fontSize: 30)
            quitButton.setCustomAttributedTitle(title: NSLocalizedString("Exit", comment: "Quit"), fontSize: 30)
            soundButton.setCustomAttributedTitle(title: NSLocalizedString("Sound", comment: "Sound"), fontSize: 30)
        default: break;
        }
        
       
        menuView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.menuView.alpha = 1.0
        }
    }
    
    func animateOut(playAgain again: Bool){
        self.view.sendSubview(toBack: visualEffectView)
        UIView.animate(withDuration: 0.2, animations: {
            
            self.menuView.alpha = 0
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.menuView.removeFromSuperview()
            if again {
                self.flipOverAllHiddenCards(isPenalty: false)
            }
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

//        let cardsCollectionViewXPosition = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//        let cardsCollectionViewYPosition = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
//        let cardsCollectionViewWidth = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (layout?.widthConstant)!)
//        let cardsCollectionViewHeight = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (layout?.heightConstant)!)

//        let timerLabelXPosition = timerLabel.centerXAnchor.constraint(equalTo: self.cardsCollectionView.centerXAnchor)
//        let timerLabelYPosition = NSLayoutConstraint(item: timerLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: self.view.bounds.height/12)
//        let timerLabelWidth = NSLayoutConstraint(item: timerLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 270)
//        let timerLabelHeight = NSLayoutConstraint(item: timerLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 54)

//   view.addConstraints([
//       cardsCollectionViewXPosition, cardsCollectionViewYPosition, cardsCollectionViewWidth, cardsCollectionViewHeight//,
// timerLabelXPosition, timerLabelYPosition, timerLabelWidth, timerLabelHeight
//     ])

/*
 чтоб сделать векторную графику - single scale + template image
 */
