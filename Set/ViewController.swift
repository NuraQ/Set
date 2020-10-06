//
//  ViewController.swift
//  Set
//
//  Created by Asal 3 on 04/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

struct designCard {
}
class ViewController: UIViewController {

    lazy var game = Matcher(initialCardsNumber: cardButtons.count)
    var extraButtonsIndex = 0
    
    override func viewDidLoad() {
        print("cards possibilir \(Card.allCardsPosibilities.count)")
        updateViewFromModel()
    }
    
    @IBOutlet var extraButtons: [UIButton]!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        updateViewFromModel()
        if let cardNum = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNum)
            updateViewFromModel()

        } else {
            print("chosen card is not in card button")
        }
    }

    @IBAction func resetGame(_ sender: UIButton) {
        extraButtonsIndex = 0
        hideExtraButtons()
        game.reset()
        game = Matcher(initialCardsNumber: 12)
        updateViewFromModel()

    }
    func hideExtraButtons () {
        for buttonIndx in 0..<extraButtons.count {
            if  cardButtons.contains(extraButtons[buttonIndx]) {
                let index = cardButtons.firstIndex(of: extraButtons[buttonIndx])
                cardButtons.remove(at: index!)
                _ = extraButtons[buttonIndx].hide
            }
            else {
                break
            }
        }
    }
    func highlightCard (at index: Int){
        if game.selectedCards.contains(game.cards[index]) {
        cardButtons[index].layer.borderWidth = 3.0
        cardButtons[index].layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        cardButtons[index].layer.cornerRadius = 8.0
        } else {
            cardButtons[index].layer.borderWidth = 0.0
            cardButtons[index].layer.cornerRadius = 0.0
        }
    }
    
    
    @IBAction func addMoreButtons(_ sender: UIButton) {
        if cardButtons.count < 24 {
            game.setsCount()
            for _ in 0..<3 {
              extraButtons[extraButtonsIndex].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
              cardButtons.append(extraButtons[extraButtonsIndex])
              extraButtonsIndex += 1
            }
            updateViewFromModel()

        }
          else{
            let Alert = UIAlertController(title: "Set Game", message: "you dont need more cards", preferredStyle:  .alert)
            let Action = UIAlertAction(title: "continue", style: .default, handler: .none)
            Alert.addAction(Action)
            present(Alert, animated: true, completion: nil)
        }
      }
    
    func cleanCompletedCards() {
        _ = game.cardsToBeCleanedIndices.map{
            _ = cardButtons[$0!].hide
        }
    
    }
    
    func updateViewFromModel () {
        scoreLabel.text = "Score: \(game.score)"

        var coloring = 1.0
        var title = ""
        var alpha = 1.0
        var color: UIColor
        for buttonIndex in cardButtons.indices {
    
            highlightCard(at: buttonIndex)
            cleanCompletedCards()
            if game.cardsToBeCleanedIndices.indices.contains(buttonIndex){
                continue
            }
            let button = cardButtons[buttonIndex]
            let card = game.cards[buttonIndex]
            switch card.shape {
            case .circle:
                title = "•"
            case .triangle:
                title = "▴"
            case .square:
                title = "▪︎"
            }
            
            switch  card.number {
               case .two:
                   title += title
               case .three:
                title += title + title
               default:
                  break
            }
            
            switch card.shading {
            case .full :
                coloring = -5.0
                alpha = 1.0
            case .half:
                coloring = 5.0
                alpha = 1.0
            case .shaded:
                coloring = -5.0
                alpha = 0.15
            }
            switch card.color {
            case .blue:
                color = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            case .red:
                color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            case .green:
                color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)

            }
            
            let attributes: [NSAttributedString.Key : Any] = [ // note: type cannot be inferred here
            .strokeWidth : coloring,
            .foregroundColor:color.withAlphaComponent(CGFloat(alpha)),
            
           ]
            let attribText = NSAttributedString(string: title , attributes: attributes)
            button.setAttributedTitle(attribText, for: UIControl.State.normal)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
        

            

        }
        
    }
}


extension UIButton {
    var hide: UIButton {
         self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         self.setAttributedTitle(nil, for: .normal)
         self.setAttributedTitle(nil, for: .normal)
         self.setTitle("", for: UIControl.State.normal)
         return self
    }
}
//@IBAction func addMoreButtons(_ sender: UIButton) {
//  let approved = game.setsCount()
//  if approved == true {
//      print("approved")
//      for _ in 0..<3 {
//          extraButtons[extraButtonsIndex].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//          cardButtons.append(extraButtons[extraButtonsIndex])
//          extraButtonsIndex += 1
//      }
//      updateViewFromModel()
//  } else{
//      let Alert = UIAlertController(title: "Set Game", message: "you dont need more cards", preferredStyle:  .alert)
//      let Action = UIAlertAction(title: "continue", style: .default, handler: .none)
//      Alert.addAction(Action)
//      present(Alert, animated: true, completion: nil)
//  }
//}
