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
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false

    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer(){
        seconds += 1
        timerLabel.text = timeString(time: TimeInterval(seconds)) //"\(seconds)"
    }
    
    func timeString(time: TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var gameContentView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBOutlet var menuView: UIView!
    
    var effect: UIVisualEffect!
    let reuseIdentifier = "cardCell"
    let game = Game()
    
    @IBAction func backToGameButton(_ sender: UIButton) {
        runTimer()
        animateOut()
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 0
        timerLabel.text = "00 : 00 : 00"
        runTimer()
        animateOut()
    }

    @IBAction func hintButton(_ sender: UIButton) {
        flipOverAllHiddenCards()
    }
    
    func flipOverAllHiddenCards(){
        for (index, card) in game.cards.enumerated() where card.isFaceUp == false {
            let cell = cardsCollectionView.cellForItem(at: [0, index]) as! CardViewCell
            cell.flipOver()
        }
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
       
        timer.invalidate()
        animateIn()
    }
    
    
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        game.delegate = self
        
        cardsCollectionView.backgroundColor = UIColor.green
        
        game.startGame()
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        runTimer()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Settings.boundWidth = self.view.bounds.width
        Settings.boundHeight = self.view.bounds.height
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        flipOverAllHiddenCards()
    }
    
    override func viewWillLayoutSubviews() {
        cardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: Settings.widthConstant)
        
        let heightConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: Settings.heightConstant)
        
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        cardsCollectionView.backgroundColor = UIColor.green
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func cardForIndexPath(indexPath: IndexPath) -> Card {
        //return cards[(indexPath as NSIndexPath).section].[(indexPath as IndexPath).row]
        
        let row = (indexPath as IndexPath).row

        return game.cards[row]
    }
    
    func cellForIndexPath(indexPath: IndexPath) -> CardViewCell {
        return cardsCollectionView.cellForItem(at: indexPath) as! CardViewCell
    }
    
}


extension GameViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CardViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CardViewCell
        let card: Card
        card = game.cards[indexPath.row]
        cell.cardImageView.image = UIImage(named: card.name)
        
        
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let cell: CardViewCell = collectionView.cellForItem(at: indexPath) as! CardViewCell
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
        <#code#>
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


