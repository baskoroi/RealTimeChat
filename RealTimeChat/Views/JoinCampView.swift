//
//  ContentView.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/21/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI
import Firebase

struct CampMenuButton: View {
    
    let text: String
    let color: Color
//    let action: () -> Void
    
    var body: some View {
//        Button(text, action: action)
//            .padding()
//            .background(color)
//            .foregroundColor(.white)
        Text(text)
            .padding(.all)
            .background(color)
            .foregroundColor(.white)
    }
}

struct JoinCampView: View {
    
    @State var nickname: String = ""
    @State var campCode: String = ""
    @State var maxPlayers: CGFloat = 5.0
    
    let dbRef = Database.database().reference()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter nickname", text: $nickname)
                    .padding(.all)
                TextField("Enter camp code", text: $campCode)
                    .padding(.all)
                
                NavigationLink(destination: ChatView()) {
                    CampMenuButton(text: "Create as host", color: .blue)
                    .padding(.all)
                }
                
                NavigationLink(destination: ChatView()) {
                    CampMenuButton(text: "Join as guest", color: .green)
                }
            }.navigationBarTitle("Camp Demo")
        }
    }
    
    func createCamp() {
        dbRef.child("camps/\(campCode)/host").setValue(nickname)
        dbRef.child("camps/\(campCode)/maxPlayers").setValue(10)
        joinCamp()
        
        print("campCode = \(campCode)")
        print("nickname = \(nickname)")
    }
    
    func joinCamp() {
        dbRef.child("members/\(campCode + "->" + nickname)/avatar").setValue("cat")
        print("campCode = \(campCode)")
        print("nickname = \(nickname)")
    }
}

struct JoinCampView_Previews: PreviewProvider {
    static var previews: some View {
        JoinCampView()
    }
}


