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
    private(set) var selectedCards = [Card]()
    private var matchedCards = [Card]()
    //NOTE: this array is used for the extraCridet point only
    private var setsOnBoard = [Card]()
    private(set) var cardsToBeCleanedIndices = [Int?]()

    private(set) var score = 0
    private var matched = false {
        didSet {
            if matched == true {
                score += 3
                _ = selectedCards.map { matchedCards.append($0) }
                removeSetCards()
            } else if matched == false {
                score -= 2
            }
        }
    }
    
    init(initialCardsNumber: Int){
        //Card.Compute()
        for _ in 1...initialCardsNumber {
            let card = Card()
            cards.append(card)
        }
        selectedCards.reserveCapacity(3)
        //calculateSetsOnBoard()
    }
    
    func reset() {
        score = 0
        selectedCards.removeAll()
        matchedCards.removeAll()
        setsOnBoard.removeAll()
        cardsToBeCleanedIndices.removeAll()
        cards.removeAll()
        Card.allCardsPosibilities = Card.createCards()
    }
    
    func chooseCard (at index: Int) {
        if  !selectedCards.contains(cards[index]),!matchedCards.contains(cards[index]),selectedCards.count < 3{
             selectedCards.append(cards[index])
        }else if selectedCards.contains(cards[index]){
            //deselect if selected and touched
            let cardIndex = selectedCards.firstIndex(of: cards[index])
            if cardIndex != nil {  selectedCards.remove(at: cardIndex! ) }
        }
         else if !matchedCards.contains(cards[index]) ,selectedCards.count == 3  {
            //Rules check
             matched = checkSet(firstCard: selectedCards[0], secondCard: selectedCards[1], thirdCard: selectedCards[2])
            selectedCards.removeAll()
            selectedCards.append(cards[index])
        }
    }
    
    private func removeSetCards(){
        let indices = selectedCards.map{
            cards.firstIndex(of: $0 )
        }
        let appended = addThreeCards(at: indices)
        cardsToBeCleanedIndices += appended ? [] : indices
        
        //NOTE: THIS IS used for the extra crider point ONLY
        setsOnBoard = setsOnBoard.filter {
            selectedCards.contains($0)
        }

    }
    
    private func addThreeCards(at indices: [Int?]) -> Bool {
        if  Card.allCardsPosibilities.count > 0 {
            for ind in 0..<3 {
                let card = Card()
                cards.remove(at: indices[ind]!)
                cards.insert(card, at: indices[ind]! )
            }
            return true
        }
        return false
    }
    
   func setsCount() {
        if Card.allCardsPosibilities.count > 0 {
            for _ in 0..<3 {
                let card = Card()
                cards.append(card)
            }
        }
    }
   private func checkSet(firstCard: Card, secondCard: Card, thirdCard: Card) -> Bool {
            let colorCheck = Card.checkRules(first: firstCard.color, second: secondCard.color, third: thirdCard.color)
            let shapeCheck = Card.checkRules(first: firstCard.shape, second: secondCard.shape, third: thirdCard.shape)
            let numberCheck = Card.checkRules(first: firstCard.number, second: secondCard.number, third: thirdCard.number)
            let shadeCheck = Card.checkRules(first: firstCard.shading, second: secondCard.shading, third: thirdCard.shading)
            return colorCheck && shapeCheck && numberCheck && shadeCheck
    }
    
//    func calculateSetsOnBoard () {
//        for first in  0..<cards.count {
//            for second in  0..<cards.count {
//                for third in  0..<cards.count {
//                    if checkSet(firstCard: cards[first], secondCard: cards[second], thirdCard: cards[third]) {
//                        setsOnBoard += [cards[first],cards[second],cards[third]]
//                    }
//
//                }
//            }
//        }
//    }
}

//func setsCount() -> Bool {
//       if setsOnBoard.count == 0 , Card.allCardsPosibilities.count > 0 {
//           for _ in 0..<3 {
//               let card = Card()
//               cards.append(card)
//           }
//           calculateSetsOnBoard()
//           return true
//       }
//       return false
//   }
