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
    let action: () -> Void
    
    var body: some View {
        Button(text, action: action)
            .padding()
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
                TextField("Enter room code", text: $campCode)
                    .padding(.all)
                CampMenuButton(text: "Create as host", color: .blue) {
                    self.createRoom()
                }
                    .padding(.all)
                CampMenuButton(text: "Join as guest", color: .green) {
                    self.joinRoom()
                }
            }.navigationBarTitle("Join Room")
        }
    }
    
    func createRoom() {
        dbRef.child("camps/\(campCode)/host").setValue(nickname)
        dbRef.child("camps/\(campCode)/maxPlayers").setValue(10)
        joinRoom()
        
        print("Created room + host!")
    }
    
    func joinRoom() {
        dbRef.child("members/\(campCode + "->" + nickname)/avatar").setValue("cat")
        print("Joined!")
    }
}

struct JoinRoomView_Previews: PreviewProvider {
    static var previews: some View {
        JoinCampView()
    }
}


