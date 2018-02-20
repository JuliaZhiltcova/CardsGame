//
//  GameModel.swift
//  Cards
//
//  Created by Admin on 14/02/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol CardsGame{
    //func flipToFace(_ cardIndices: [Int])
    //func flipToBack(_ cardIndices: [Int])
    func flip(_ cardIndices: [Int], toFace direction: Bool)
}

class Game{

    let stage = 4
    var cards: [Card] = [Card]()
    var cardsOpened = [Card]()
    var delegate: CardsGame?
    
    func createRandomCardsArray(){
        for card in 0..<(Settings.ElementsPerRowAndColumn[stage - 1][0]/2 ){
            let item = Card(id: card, name: "Img\(card)")
            cards.append(item)
            cards.append(item.copy() as! Card)
        }
        
        return cards.shuffled()
    }
    
    
    func startGame()  {
        createRandomCardsArray()
    }
    
    func finishGame() {
    
    }
    
    func didSelectCard(_ card: Card){
        
        
        if card.isFaceUp { return }
        
        //flipToFace([card])
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
                   // self.flipToBack(cardsOpened1)
                    self.flip(cardsOpened1, toFace: false)
                    cardsOpened1.removeAll()
                }
                cardsOpened.removeAll()
            }
            
        } else {
            cardsOpened.append(card)
            cards[indexByCard(card)].isFaceUp = true
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
    
   /* func flipToFace(_ cards: [Card]){
        var cardIndices = [Int]()
        for item in cards {
            let index = indexByCard(item)
            cardIndices.append(index)
        }
        delegate?.flipToFace(cardIndices)
    }
    
    
    func flipToBack(_ cards: [Card]){
        var cardIndices = [Int]()
        for item in cards {
            let index = indexByCard(item)
            cardIndices.append(index)
        }
        delegate?.flipToBack(cardIndices)
    } */
    
    
    func indexByCard(_ card: Card) -> Int{
        return cards.index(where: {$0 === card})!
    }

}


