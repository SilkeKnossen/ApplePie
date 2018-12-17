//
//  ViewController.swift
//  ApplePie
//
//  Created by Silke Knossen on 06/11/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Initialize a Game which is the current game.
    var currentGame: Game!
    
    // Initialize the words for the game. Shuffle this list each
    // time the game is played to give it a replay value.
    var listOfWords = ["ages", "dragon", "omni", "angel", "eon", "plasma", "armor", "fallen", "scale", "ashen", "fang", "scar", "atomic", "flame", "scarlet", "black", "fire", "shade", "blade", "firefight", "shadow", "blaze", "galaxy", "storm", "burn", "hades", "steel", "chaos", "incendiary", "sworn", "chrome", "jade", "tornadic", "claw", "void", "crimson", "light", "vortex", "crypt", "oath", "wing", "draconic", "oblivion", "xeno"]
    
    // Initialize the shuffled list of words to add replay value.
    var shuffledListOfWords = [String]()
    
    // Initialize number of incorrect moves that are allowed.
    let incorrectMovesAllowed = 7
    
    // Initialize total wins, and set to 0 each new round.
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    // Initialize total losses, and set to 0 each new round.
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // Initialize the words that are quessed correctly.
    // Reguired for the extra label.
    var correctWordsList: [String] = []

    // Initialize all outlets.
    @IBOutlet weak var guessedWordsLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    // When the view did load, start a new round.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shuffledListOfWords = listOfWords.shuffled()
        newRound()
    }
    
    /* When a letter button is pressed, disable the button.
     * Check if the letter is in the word to quess, and update
     * the players state in the game.
     */
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for : .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    // Update the game state variables and update the view.
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            correctWordsList.append(currentGame.word)
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    /* Start a new round with the next word from the shuffled words-to-guess-list.
     * Create a new game struct are reset all variables, including
     * enabling the letter buttons. If all words are guessed,
     * unable the letter buttons to avoid errors.
     */
    func newRound() {
        if !shuffledListOfWords.isEmpty {
            let newWord = shuffledListOfWords.removeFirst()
            currentGame = Game.init(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    // Enable letter buttons to be pressed.
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // Updates all labels in the view to match the game state.
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        // The extra label: When no word is correctly guessed,
        // the label shows you that.
        // If you correctly guessed words, the label show the words.
        if correctWordsList.count == 0 {
            guessedWordsLabel.text = "You haven't guessed any word right yet."
        } else {
            let wordsCorrect = correctWordsList.joined(separator: ", ")
            guessedWordsLabel.text = "Correct words: \(wordsCorrect)"
        }
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named:
            "Tree \(currentGame.incorrectMovesRemaining)")
    }
}

