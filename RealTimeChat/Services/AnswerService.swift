//
//  MessageService.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/21/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import Foundation
import Firebase

class AnswerService: ObservableObject {
    
    var chatRef = Database.database().reference().child("testMessages")
    var chatHandle: UInt?
    
    func observeIncomingAnswers(completion: @escaping (AnswerViewModel?) -> Void) {
        
        chatHandle = chatRef.observe(.childAdded, with: { (message) in
            if let value = message.value as? [String: Any] {
                
                let viewModel = AnswerViewModel(nickname: value["nickname"] as? String,
                                                message: value["message"] as? String,
                                                avatarURL: value["avatarURL"] as? String,
                                                timestamp: Date().timeIntervalSince1970,
                                                foregroundColor: .white,
                                                backgroundColor: .blue)
                
                completion(viewModel)
            } else {
                completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func sendAnswer(nickname: String, avatarURL: String, message: String) {
        self.chatRef.childByAutoId().setValue([
           "nickname": nickname,
           "avatarURL": avatarURL,
           "message": message,
           "timestamp": Date().timeIntervalSince1970,
        ])
    }
    
    deinit {
        if let handle = chatHandle {
            self.chatRef.removeObserver(withHandle: handle)
        }
    }
}
