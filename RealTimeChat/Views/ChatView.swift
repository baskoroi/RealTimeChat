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
    @State var answers = [AnswerViewModel]()
    
    @ObservedObject var keyboard = KeyboardResponder()
    
    init() {
        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
            UITableView.appearance().tableFooterView = UIView()
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }

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

struct MessageCell: View {
    
    let viewModel: AnswerViewModel!
    
    var body: some View {
        HStack {
            Image(viewModel.avatarURL!).resizable().aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 36, alignment: .leading)
            VStack(alignment: .leading) {
                Text(viewModel.nickname!).font(.caption).bold()
                Text(viewModel.message!)
                    .padding(.all, 12)
                    .background(viewModel.backgroundColor)
                    .cornerRadius(12)
                    .foregroundColor(viewModel.foregroundColor)
            }
        }
    }
}
