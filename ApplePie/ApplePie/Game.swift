//
//  Game.swift
//  ApplePie
//
//  Created by Silke Knossen on 06/11/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

/*
 * Game struct to store variables that defines a game which
 * includes one word to be guessed.
 */
struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    // Keep the incorrect moves remaining up-to-date.
    // Checks if the guessed letter is correct or wrong.
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    // The letters of the word to guess that are guessed
    // correctly are visible, the others not.
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
