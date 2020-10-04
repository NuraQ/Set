//
//  Card.swift
//  Set
//
//  Created by Asal 3 on 04/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import Foundation

struct Card{
    var identifier: Int = 0;
    
    private static var identifierFactory = 0
    
    private static func generateUniqueIdentifier() -> Int{
    identifierFactory += 1
    return identifierFactory
        
    }
    
    init(){
        self.identifier = Card.generateUniqueIdentifier()
    }

}
