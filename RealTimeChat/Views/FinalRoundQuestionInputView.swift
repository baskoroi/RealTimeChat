//
//  FinalRoundQuestionForm.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/23/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI

struct FinalRoundQuestionInputView: View {
    
    @ObservedObject var questionService = QuestionService()
    @State var questions = [QuestionViewModel]()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Random questions:\n")
            Spacer()
            List {
                ForEach(self.questions, id: \.id) { (question) in
                    Text(question.text ?? "N/A")
                }
            }.onAppear {
                self.questionService.getRandomQuestions(on: 1, campCode: "", errorFetchingBlock: { (error) in
                    if let err = error {
                        print("ERROR")
                        print(err.localizedDescription)
                        return
                    }
                }) { (error, questionVM) in
                    if let err = error {
                        print("ERROR")
                        print(err.localizedDescription)
                        return
                    }
                    
                    guard let viewModel = questionVM else { return }
                    
                    self.questions.append(viewModel)
                }
//                self.questions = self.questionService.currentRoundQuestionVMs
            }
//            Button(action: {
//                self.questionService.getRandomQuestions(on: 1, campCode: "", errorFetchingBlock: { (error) in
//                    if let err = error {
//                        print("ERROR")
//                        print(err.localizedDescription)
//                        return
//                    }
//                })
//                self.questions = self.questionService.currentRoundQuestionVMs
//            }) {
//                Text("Find question count in round 1")
//            }
//            .padding(.bottom, 16)
//            Button(action: {
//                self.questionService.getRandomQuestions(on: 2, campCode: "", errorFetchingBlock: { (error) in
//                    if let err = error {
//                        print("ERROR")
//                        print(err.localizedDescription)
//                        return
//                    }
//                })
//                self.questions = self.questionService.currentRoundQuestionVMs
//            }) {
//                Text("Find question count in round 2")
//            }
            Spacer()
        }
    }
    
    var temp_getSubmittedQuestion: some View {
        VStack {
            Text("Question text: \(self.questionService.submittedQuestionVM.text ?? "Loading...")")
            Button(action: {
                self.questionService.submitFinalRoundQuestion(
                    campCode: "CAMPRET",
                    text: "This question here...")
            }) {Text("Submit final round")}
        }
    }
}

struct FinalRoundQuestionInputView_Previews: PreviewProvider {
    static var previews: some View {
        FinalRoundQuestionInputView()
    }
}
