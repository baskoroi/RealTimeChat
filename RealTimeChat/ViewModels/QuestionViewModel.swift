//
//  QuestionViewModel.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/23/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import Foundation
import Combine

class QuestionViewModel: ObservableObject, Identifiable {
    
    var id = UUID()
    
    @Published var text: String?
    @Published var round: Int?
    @Published var index: Int?
    
    init() {}
    
    init(text: String?, round: Int?) {
        self.text = text
        self.round = round
    }
    
    init(text: String?, round: Int?, index: Int?) {
        self.text = text
        self.round = round
        self.index = index
    }
}
