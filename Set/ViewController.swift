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
    var flipCount = 0;
    var shapes = [String: String]()
    var extraButtonsIndex = 0 
    override func viewDidLoad() {
        addShapes()
    }
    @IBOutlet var extraButtons: [UIButton]!

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        addShapes()
        flipCount += 1
        if let cardNum = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNum)
           // highlightCard(at: cardNum)
            addShapes()
        } else {
            print("chosen card is not in card button")
        }
        
    }

    func updateViewFromModel () {
        for _ in cardButtons.indices {
//         let button = cardButtons[index]
        
               
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
        let approved = game.setsCount()
        if approved {
            for _ in 0..<2 {
                extraButtons[0].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
     
        
          //  addShapes()
      }
    
    
    
    func addShapes () {
           shapes["circle"] = "●"
           shapes["triangle"] = "▲"
           shapes["square"] = "◼︎"
        var coloring = 1.0
            var title = ""
        var alpha = 1.0
        var color: UIColor
        for buttonIndex in cardButtons.indices {
            let button = cardButtons[buttonIndex]
            let card = game.cards[buttonIndex]
            highlightCard(at: buttonIndex)
            switch  card.shape {
            case .circle:
                title = shapes["circle"] ?? "?"
            case .triangle:
                title = shapes["triangle"] ?? "?"
            case .square:
                title = shapes["square"] ?? "?"

                       
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
