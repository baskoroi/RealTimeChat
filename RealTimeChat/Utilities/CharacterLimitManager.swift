//
//  CharacterLimitManager.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/30/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import Foundation

class CharacterLimitManager: ObservableObject {
    
    var characterLimit: Int
    var count: String {
        return "\(text.count)/\(characterLimit)"
    }
    
    init(characterLimit: Int) {
        self.characterLimit = characterLimit
    }
    
    @Published var text: String = "" {
        didSet {
            if text.count > characterLimit {
                text = String(text.prefix(characterLimit))
            }
        }
    }
}
