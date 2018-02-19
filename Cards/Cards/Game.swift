//
//  GameModel.swift
//  Cards
//
//  Created by Admin on 14/02/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol CardsGame{
    func flipToFace(_ cardIndices: [Int])
    func flipToBack(_ cardIndices: [Int])
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
        
        
       // cards.forEach { card in
       //     print(Unmanaged<AnyObject>.passUnretained(card as AnyObject).toOpaque())
       // }
        
        return cards.shuffled()
    }
    
    
    func startGame()  {
        createRandomCardsArray()
    }
    
    func finishGame() {
    
    }
    
    func didSelectCard(_ card: Card){
        
        
        if card.isFaceUp { return }                                         //card is already opened
        
        flipToFace([card])
        
        
        if !cardsOpened.isEmpty {                                                            // в cardsOpened есть первая карточка
            
            if card.id == cardsOpened[0].id {                               //карточки совпали
                cards[indexByCard(card)].isFaceUp = true
                cardsOpened.removeAll()
            } else {                                                        //карточки не совпали
                cards[indexByCard(cardsOpened[0])].isFaceUp = false
                cardsOpened.append(card)
                var cardsOpened1 = cardsOpened
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.flipToBack(cardsOpened1)
                    cardsOpened1.removeAll()
                }
                cardsOpened.removeAll()
            }
            
        } else {
            cardsOpened.append(card)
            cards[indexByCard(card)].isFaceUp = true
        }
        
    }
    
    func flipToFace(_ cards: [Card]){
        var cardIndices = [Int]()
        for item in cards {
            let index = indexByCard(item)
            cardIndices.append(index)
        }
        print("Card indices \(cardIndices)")
        delegate?.flipToFace(cardIndices)
    }
    
    
    func flipToBack(_ cards: [Card]){
        var cardIndices = [Int]()
        for item in cards {
            let index = indexByCard(item)
            cardIndices.append(index)
        }
        delegate?.flipToBack(cardIndices)
    }
    
    
    func indexByCard(_ card: Card) -> Int{
        return cards.index(where: {$0 === card})!
    }

}



/*
func didSelectCard(_ card: Card){
    
    
    if card.isFaceUp { return }                                         //card is already opened
    
    flipToFace([card])
    
    if cardsOpened.isEmpty {                                            // в cardsOpened ничего нет
        
        cardsOpened.append(card)
        cards[indexByCard(card)].isFaceUp = true
        
    } else {                                                            // в cardsOpened есть первая карточка
        
        if card.id == cardsOpened[0].id {                               //карточки совпали
            cards[indexByCard(card)].isFaceUp = true
            cardsOpened.removeAll()
        } else {                                                        //карточки не совпали
            cards[indexByCard(cardsOpened[0])].isFaceUp = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.flipToBack(self.cardsOpened)
            }
            //cardsOpened.removeAll()
        }
        
    }
}*/
