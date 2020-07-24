//
//  QuestionService.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/22/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import Foundation
import Firebase

class QuestionService: ObservableObject {
    
    private var questionRef = Database.database().reference().child("questions")
    private var questionHandle: UInt?
    
    @Published var submittedQuestionVM = QuestionViewModel()
    @Published var currentRoundQuestionVMs = [QuestionViewModel]()
    
    func submitFinalRoundQuestion(campCode: String,
                                  text questionText: String) {
        
        questionRef.child("round3/\(campCode)/submitted")
            .childByAutoId()
            .setValue(["text": questionText]) { (error, dbRef) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.submittedQuestionVM = QuestionViewModel(text: questionText, round: 3)
                print(self.submittedQuestionVM)
        }
    }
    
    private func getQuestionCount(
        on round: Int,
        campCode: String,
        errorFetchingBlock: @escaping (Error?) -> Void,
        completion: @escaping (Error?, QuestionViewModel?) -> Void) {
        
        
        
    }
    
    func getRandomQuestions(on round: Int,
                            campCode: String,
                            errorFetchingBlock: @escaping (Error?) -> Void,
                            completion: @escaping (Error?, QuestionViewModel?) -> Void) {
        
        let childPath = round == 3 ? "round3/\(campCode)/count" : "round\(round)/count"
        
        // get number of questions for current round
        print("ROUND #\(round)")
        questionRef.child("round\(round)/count").observeSingleEvent(of: .value, with: { (snapshot) in
            if let count = snapshot.value as? Int {
                print("Question count =", count)
                
                // make an array of 3 random numbers (i.e. zero-based indexes in DB)
                var indexes = [Int]()
                while indexes.count < 3 {
                    let randomIndex = Int.random(in: 0..<count)
                    if !indexes.contains(randomIndex) {
                        indexes.append(randomIndex)
                    }
                }
                
                self.fetchQuestions(on: round, with: indexes, completion: completion)
            }
        }) { (err) in
            print(err.localizedDescription)
            errorFetchingBlock(err)
        }
    }
    
    // only for rounds 1 and 2, questions for round 3 are voted by players
    func fetchQuestions(on round: Int,
                        with indexes: [Int],
                        completion: @escaping (Error?, QuestionViewModel?) -> Void) {
        
        print("Question indexes: ", indexes)
        
        // reset currentRoundQuestions for current round - esp if some questions exist within
        currentRoundQuestionVMs.removeAll()
                
        // loop per index
        // questionNumber orders the question for the current round (i.e. first, second, or third question)
        // questionDBIndex is the index from which the questions' data are retrieved from the database
        for (questionNumber, questionDBIndex) in indexes.enumerated() {
            // query question index equals index of current loop
            questionRef
                .child("round\(round)")
                .queryOrdered(byChild: "index")
                .queryEqual(toValue: questionDBIndex)
                .observeSingleEvent(
                    of: .value,
                    with: { (snapshot) in
                        
                        // append to questions array -> assigned to self.currentRoundQuestionVMs
                        print("Round #\(round) - Question idx \(questionDBIndex)")
                            
                        guard let values = snapshot.value as? [String: Any] else {
                            completion(nil, nil)
                            return
                        }
                        for (_, value) in values {
                            
                            // get inner object to skip auto ID from Firebase
                            guard let value = value as? [String: Any] else {
                                completion(nil, nil)
                                return
                            }
                            
                            let viewModel = QuestionViewModel(
                                text: value["text"] as? String,
                                round: round,
                                index: questionNumber)
                            print(viewModel.round, viewModel.index, viewModel.text)
                            self.currentRoundQuestionVMs.append(viewModel)
                            completion(nil, viewModel)
                        }
                }) { (error) in
                    print(error.localizedDescription)
                    completion(error, nil)
            }
        }
    }
    
    func observeIncomingFinalRoundQuestion(campCode: String) {
        questionRef
            .child("round3/\(campCode)/submitted")
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? [String: Any],
                    let text = value["text"] as? String {
                    
                    print("Question text: ", text)
                    print("Question round: ", round)
                    
                    self.submittedQuestionVM = QuestionViewModel(text: text, round: 3)
                }
            })
    }
    
    deinit {
        if let handle = questionHandle {
            questionRef.removeObserver(withHandle: handle)
        }
    }
}
