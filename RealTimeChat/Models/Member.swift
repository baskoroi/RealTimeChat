//
//  Player.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/21/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import Foundation

struct Member {
    let camp: Camp
    let isHost: Bool
    let stageName: String
    let realName: String
    let avatarURL: String
}

extension Member {
    static func getRandomName() -> String {
        return [
            "Caitlin Hall", "Charmaine Cross", "Maynard Arellano", "Micheal Yu", "Mona Olsen", "Iris Benson",
            "Garfield Stout", "Gaston Crawford", "Cecelia Weber", "Edwina Ayala", "Hank Bass", "Faye Mccarty",
            "Monique Rhodes", "Alex Payne", "Damon Silva", "Ana Glass", "Karen Wade",
            "Shelly Austin", "Kelly Diaz", "Ruthie Dawson", "Markus Clay", "Alberto Gill", "Marshall Combs",
            "Eddie Khan", "Harriet Grant", "Werner Bullock", "Ilene Webb", "Tamera Lane", "Michal Gallegos",
            "Santo Berry", "Rosendo Avery",   "Ester Daniel",  "Delmar Sellers",  "Fermin Massey", "Melanie Ashley",
        ].randomElement() ?? "Barito Barita"
    }
    
    static func getRandomAvatar() -> String {
        return ["cow", "dog", "fox", "penguin", "rabbit", "tiger",].randomElement() ?? "cow"
    }
}
