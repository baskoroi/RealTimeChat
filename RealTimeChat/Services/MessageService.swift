//
//  MessageService.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/21/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import Foundation

class AnswerService: ObservableObject {
    
    @Published var messages = [AnswerViewModel]()
    
}
