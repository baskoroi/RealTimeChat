//
//  AvatarSelectionView.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/22/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI

struct AvatarSelectionView: View {
    
    @State private var isAdded = false
    var memberService = MemberService()
    var questionService = QuestionService()
    
    var body: some View {
//        Button(action: {
//            self.memberService.create(campCode: "CAMPRET", member: MemberViewModel(isHost: false, stageName: "Felix", realName: "Felipe Andreoli", avatarURL: "cat"))
//        }) {
//            Text("Create member")
//        }
        
       
        Text("Select avatar here..")
        
        
//            self.memberService.create(campCode: "CAMPTEST", member: MemberViewModel(isHost: false, stageName: "sapiku", realName: "Saitama Kampret", avatarURL: "cow"))
//            self.memberService.observeCreation { (isCreated) in
//                self.isAdded = isCreated
    }
}

struct AvatarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectionView()
    }
}
