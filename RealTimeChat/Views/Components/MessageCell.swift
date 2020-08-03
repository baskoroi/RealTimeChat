//
//  MessageCell.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/28/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI

struct MessageCell: View {
    
    let viewModel: AnswerViewModel!
    
    let nicknameFont = Font.custom("Montserrat-Semibold", size: 12)
    let messageFont = Font.custom("Montserrat-Regular", size: 16)
    
    public var body: some View {
        HStack {
            if viewModel.isMyOwn {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("(you) \(viewModel.nickname!)").font(nicknameFont).bold()
                        .foregroundColor(.white)
                    Text(viewModel.message!)
                        .font(messageFont)
                        .padding(.all, 12)
                        .background(viewModel.backgroundColor)
                        .cornerRadius(12)
                        .foregroundColor(viewModel.foregroundColor)
                }
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Image("avatarback")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                    Image(viewModel.avatarURL!).resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 42, height: 42, alignment: .center)
                }
            } else {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Image("avatarback")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                    Image(viewModel.avatarURL!).resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 42, height: 42, alignment: .leading)
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.nickname!).font(nicknameFont).bold()
                        .foregroundColor(.white)
                    Text(viewModel.message!)
                        .font(messageFont)
                        .padding(.all, 12)
                        .background(viewModel.backgroundColor)
                        .cornerRadius(12)
                        .foregroundColor(viewModel.foregroundColor)
                }
                Spacer()
            }
        }.padding(.horizontal, 16)
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageCell(viewModel: AnswerViewModel(nickname: "cow ada di hatiku", message: "his test message is here, and this is his longer sentence to visualize to you how the cell expands", isMyOwn: false, avatarURL: "binatang-1", timestamp: Date().timeIntervalSince1970, foregroundColor: .black, backgroundColor: .white))
            MessageCell(viewModel: AnswerViewModel(nickname: "tigerman", message: "this is your own message, you might speak a little or much... I don't know :)", isMyOwn: true, avatarURL: "binatang-2", timestamp: Date().timeIntervalSince1970, foregroundColor: .black, backgroundColor: .white))
        }.background(Color(red: 0.059, green: 0.154, blue: 0.209))
    }
}
