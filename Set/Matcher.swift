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
        selectedCards.reserveCapacity(3)
    }
    
    func chooseCard (at index: Int) {
        if  !selectedCards.contains(cards[index]),!matchedCards.contains(cards[index]),selectedCards.count < 3{
            print("enter")
            selectedCards.append(cards[index])
        }else if selectedCards.contains(cards[index]){
            let cardIndex = selectedCards.firstIndex(of: cards[index])
            if cardIndex != nil {  selectedCards.remove(at: cardIndex! ) }
        }
         else if !matchedCards.contains(cards[index]) ,selectedCards.count == 3  {
            //comparision
            let matched = checkSet(card: cards[index])
            if matched == true {
                matchedCards.append(cards[index])
                print("match")
            }else{
                print("not")

            }
            
        }
    }
    
    func deselectCards(){
  selectedCards.removeAll()
    }
    func checkSet(card: Card) -> Bool {
            let colorCheck = Card.checkRules(first: selectedCards[2].color, second: selectedCards[0].color, third: selectedCards[1].color)
            let shapeCheck = Card.checkRules(first: selectedCards[2].shape, second: selectedCards[0].shape, third: selectedCards[1].shape)
            let numberCheck = Card.checkRules(first: selectedCards[2].number, second: selectedCards[0].number, third: selectedCards[1].number)
            let shadeCheck = Card.checkRules(first: selectedCards[2].shading, second: selectedCards[0].shading, third: selectedCards[1].shading)

            return colorCheck && shapeCheck && numberCheck && shadeCheck
    }
}
