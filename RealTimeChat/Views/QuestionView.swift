//
//  Question.swift
//  sesamamu
//
//  Created by Yohanes Markus Heksan on 27/07/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    //DB
    @State var ronde: String = "Ronde 1"
    @State var question: String = "Ada seorang gadis bernama Angel. Angel pergi membawa uang 70.000 untuk membeli sebuah buku seharga 50.000. Di jalan Angel beli bubur seharga 25.000. Kalau kamu jadi Angel, buburnya diaduk ga? Filosofinya?"
        
    @ObservedObject var charLimiter = CharacterLimitManager(characterLimit: 150)

    @ObservedObject var keyboard = KeyboardResponder()
    
//    @State var offSetValueForKeyboard: CGFloat = 0

    
    var body: some View {
        VStack{
            Text("\(self.ronde)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 10)
            Text("Pertanyaan 1/3")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            Rectangle()
                .frame(width: 30, height: 3)
                .foregroundColor(.white)
                .padding(.vertical, 10)
            VStack{
                Text("\(self.question)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width*0.8)
            }
            Spacer()
            
            ZStack {
                TextField("Jawab di sini ya", text: self.$charLimiter.text)
                    .lineLimit(4) // multiline
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .frame(width: UIScreen.main.bounds.width - 36, height: 160, alignment: .center)
                    .fixedSize(horizontal: true, vertical: false)
                    .background(Color.white)
                    .cornerRadius(12)
                Text(self.charLimiter.count)
                    .foregroundColor(.gray)
                    .offset(x: UIScreen.main.bounds.width/2 - 54, y: 54)
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Lanjut")
                    .font(Font.custom("Montserrat-Bold", size: 28))
                    .foregroundColor(.yellow)
                    .padding(.horizontal, 72)
                    .padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color(red: 0.19, green: 0.425, blue: 0.431)))
                    .padding(.vertical, 24)
            }
        }
        .modifier(FullScreen())
        .offset(x: 0, y: -self.keyboard.currentHeight)
        .background(
            Image("backgroundhome2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
            .onTapGesture {
                self.hideKeyboard()
        }
    }
    
//    func pushForKeyboard() {
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { key in
//            let value = key.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//            self.offSetValueForKeyboard = value.height
//        }
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { key in
//            self.offSetValueForKeyboard = 0
//        }
//    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            QuestionView().previewDevice("iPhone 11")
            QuestionView().previewDevice("iPhone 8")
        }
    }
}
