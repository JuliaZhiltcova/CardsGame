//
//  ViewController.swift
//  Cards
//
//  Created by Admin on 29/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    @IBAction func hintButton(_ sender: UIButton) {
    
        for (index, card) in game.cards.enumerated() where card.isFaceUp == false {
            let cell = cardsCollectionView.cellForItem(at: [0, index]) as! CardViewCell
            cell.flipOver()
        }
    }
    
    @IBAction func menuButton(_ sender: UIButton) {

    }
    
    let reuseIdentifier = "cardCell"
    
    let game = Game()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        game.delegate = self
        
        cardsCollectionView.backgroundColor = UIColor.green
        
        game.startGame()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func cardForIndexPath(indexPath: IndexPath) -> Card {
        //return cards[(indexPath as NSIndexPath).section].[(indexPath as IndexPath).row]
        
        let row = (indexPath as IndexPath).row
        print(row)
        
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
        // print(indexPath)
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
    
 /*   func flipToFace(_ cardIndices: [Int]){
        for item in cardIndices {
            let indexPath = IndexPath(row: item, section: 0)
            let cell = cellForIndexPath(indexPath: indexPath)
            cell.flipCard(flipToFace: true)
        }
    }
    
    func flipToBack(_ cardIndices: [Int]){
        for item in cardIndices {
            let indexPath = IndexPath(row: item, section: 0)
            let cell = cellForIndexPath(indexPath: indexPath)
            cell.flipCard(flipToFace: false)
        }
    }
   */
    
    func flip(_ cardIndices: [Int], toFace direction: Bool){
        for item in cardIndices {
            let indexPath = IndexPath(row: item, section: 0)
            let cell = cellForIndexPath(indexPath: indexPath)
            cell.flipCard(flipToFace: direction)
        }
    }
}




/*
 func flipArray(arrayOfCells: [CardViewCell]){
 for cell in arrayOfCells {
 cell.flipCard(flipToFace: false)
 }
 }*/


//var  previousIndexPath : IndexPath?
//var  previousCell: CardViewCell?

//extension GameViewController:  {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        
//        if (game.cards[indexPath.row].isFaceUp == true) { return }
//        game.cards[indexPath.row].isFaceUp = true
//        
//        let cell: CardViewCell = collectionView.cellForItem(at: indexPath) as! CardViewCell
//        cell.flipCard(flipToFace: true)
//
//      
//        
//        if let prevIndexPath = previousIndexPath{
//            if game.cards[indexPath.row].id == game.cards[prevIndexPath.row].id {
//                previousIndexPath = nil
//                return
//            } else {
//                game.cards[indexPath.row].isFaceUp = false
//                game.cards[prevIndexPath.row].isFaceUp = false
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                    previousCell?.flipCard(flipToFace: false)
//                    cell.flipCard(flipToFace: false)
//                    previousIndexPath = nil
//                    previousCell = nil
//                }
//            }
//        }
//        if let prevIndexPath = previousIndexPath {
//            previousCell = (collectionView.cellForItem(at: prevIndexPath) as! CardViewCell)
//        }
//        previousIndexPath = indexPath
//     
//    }
//}

