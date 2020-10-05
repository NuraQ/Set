//
//  Matcher.swift
//  Set
//
//  Created by Asal 3 on 04/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import Foundation



class Matcher {
    
    private(set) var cards = [Card]()
    var selectedCards = [Card]()
    var matchedCards = [Card]()
    
    init(initialCardsNumber: Int){
        for _ in 1...initialCardsNumber {
            let card = Card()
            cards.append(card)
        }
    }
    
    func chooseCard (at index: Int) {
        if !selectedCards.contains(cards[index]),!matchedCards.contains(cards[index]){
            selectedCards.append(cards[index])
        }else if !matchedCards.contains(cards[index]),selectedCards.contains(cards[index]){
            //comparision 
        }
    }
}
