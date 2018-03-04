//
//  GameModel.swift
//  Cards
//
//  Created by Admin on 14/02/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol CardsGame{
    func gameDidStart()
    func flip(_ cardIndices: [Int], toFace direction: Bool)
    func gameDidEnd()
}

class Game{

    let stage = 3
    var cards: [Card] = [Card]()
    var cardsOpened = [Card]()
    var delegate: CardsGame?

    
    func createRandomCardsArray(){
        for card in 0..<(Settings.ElementsPerRowAndColumn[stage - 1][0]/2 ){
            let item = Card(id: card, name: "Img\(card)")
            cards.append(item)
            cards.append(item.copy() as! Card)
        }

       // cards.forEach { card in
       //     print(Unmanaged<AnyObject>.passUnretained(card as AnyObject).toOpaque())
       // }
        return cards.shuffled()
    }
    
    
    func startNewGame()  {
        createRandomCardsArray()

//        cards.forEach { card in
//            print("\(card.id) -- \(card.name) -- \(card.isFaceUp)" )
//        }
//        print("---------")

        delegate?.gameDidStart()
    }
    
    func finishGame() {
        cards.removeAll()
        cardsOpened.removeAll()

        delegate?.gameDidEnd()
    }
    
    func didSelectCard(_ card: Card){
        
        
        if card.isFaceUp { return }

        flip([card], toFace: true)
        
        if !cardsOpened.isEmpty {
            
            if card.id == cardsOpened[0].id {
                cards[indexByCard(card)].isFaceUp = true
                cardsOpened.removeAll()
            } else {
                cards[indexByCard(cardsOpened[0])].isFaceUp = false
                cardsOpened.append(card)
                var cardsOpened1 = cardsOpened
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.flip(cardsOpened1, toFace: false)
                    cardsOpened1.removeAll()
                }
                cardsOpened.removeAll()
            }
            
        } else {
            cardsOpened.append(card)
            cards[indexByCard(card)].isFaceUp = true
        }
        
        if ((cards.filter{ $0.isFaceUp == false}.count)  == 0) {
            finishGame()
        }
        
    }
    
    func flip(_ cards: [Card], toFace: Bool){
        var cardIndices = [Int]()
        for item in cards {
            let index = indexByCard(item)
            cardIndices.append(index)
        }
        delegate?.flip(cardIndices, toFace: toFace)
    }
    
    
    func indexByCard(_ card: Card) -> Int{
        return cards.index(where: {$0 === card})!
    }

}


