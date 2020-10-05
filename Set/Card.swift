//
//  Card.swift
//  Set
//
//  Created by Asal 3 on 04/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import Foundation

struct Card: Equatable{
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color &&
               lhs.number == rhs.number &&
               lhs.shading == rhs.shading &&
               lhs.shape == rhs.shape

    }
    enum Number  : CaseIterable  { case one, two, three }
     enum Shape   : CaseIterable { case circle, square, triangle }
     enum Color   : CaseIterable { case red, green, blue }
     enum Shading : CaseIterable { case quarter, half, full }
     let number : Number
     let shape  : Shape
     let color  : Color
     let shading: Shading

     static let allCardsPosibilities: [Card] = {
       var cards: [Card] = []
       for number in Number.allCases {
         for shape in Shape.allCases {
           for color in Color.allCases {
             for shading in Shading.allCases {
               cards.append(Card(number: number, shape: shape, color: color, shading: shading))
             }
           }
         }
       }
       return cards
     }()

   

}
