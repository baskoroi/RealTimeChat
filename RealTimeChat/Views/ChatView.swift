//
//  ChatView.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/21/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatView: View {
    
    @State var nickname = Member.getRandomName()
    @State var avatarURL = Member.getRandomAvatar()
    @State var myMessage = ""
    
    @ObservedObject var answerService = AnswerService()
//    @State var answers = [AnswerViewModel]()
    @State private var answers: [AnswerViewModel] = [
        AnswerViewModel(nickname: "maung", message: "beliminumnyadulukak. huruf kecil semua", avatarURL: "binatang-1", timestamp: Date().timeIntervalSince1970, foregroundColor: .black, backgroundColor: .white),
        AnswerViewModel(nickname: "BIBIBIBI", message: "admin123", avatarURL: "binatang-2", timestamp: Date().timeIntervalSince1970, foregroundColor: .black, backgroundColor: .white),
        AnswerViewModel(nickname: "BIBIBIBI", message: "admin123", isMyOwn: true, avatarURL: "binatang-3", timestamp: Date().timeIntervalSince1970, foregroundColor: .black, backgroundColor: .white),
    ]
    
    @ObservedObject var keyboard = KeyboardResponder()
    
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(answers, id: \.self) { answer in
                    MessageCell(viewModel: answer)
                }
            }.onAppear {
                self.answerService.observeIncomingAnswers { answerValue in
                    if let answer = answerValue {
                        self.answers.append(answer)
                    }
                    
                    // re-sort answers by their timestamps
                    self.answers.sort {
                        $0.timestamp < $1.timestamp
                    }
                }
            }
            HStack(alignment: .bottom) {
                TextField("Message...", text: $myMessage)
                    .disableAutocorrection(true)
                Button(action: {
                    self.sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                }
            }.padding(.all)
        }.navigationBarTitle("Chat!")
        .padding(.bottom, keyboard.currentHeight)
        .animation(.easeOut(duration: 0.16))
    }
    
    func sendMessage() {
        
        guard !myMessage.isEmpty else { return }
        
        // create new message data
        answerService.sendAnswer(nickname: nickname,
                                 avatarURL: avatarURL,
                                 message: myMessage)
        
        // reset to blank at every send
        myMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}


