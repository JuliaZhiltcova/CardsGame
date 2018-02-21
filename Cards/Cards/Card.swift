//
//  Card.swift
//  Cards
//
//  Created by Admin on 29/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Card {

    let id: Int
    let name: String
    var isFaceUp: Bool

    
    init(id: Int, name: String){
        self.id = id
        self.name = name
        isFaceUp = false
    }
}

extension Card: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return Card(id: self.id, name: self.name) 
    }

}

