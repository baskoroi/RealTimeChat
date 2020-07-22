//
//  AnswerViewModel.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/21/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI
import Combine

struct AnswerViewModel: Hashable {
    var id = UUID()

    var nickname: String?
    var message: String?
    var avatarURL: String?
    var timestamp: TimeInterval
    var foregroundColor: Color = .white
    var backgroundColor: Color = .blue
}
