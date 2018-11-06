//
//  ViewController.swift
//  ApplePie
//
//  Created by Silke Knossen on 06/11/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["ages", "dragon", "omni", "angel", "eon", "plasma", "armor", "fallen", "scale", "ashen", "fang", "scar", "atomic", "flame", "scarlet", "black", "fire", "shade", "blade", "firefight", "shadow", "blaze", "galaxy", "storm", "burn", "hades", "steel", "chaos", "incendiary", "sworn", "chrome", "jade", "tornadic", "claw", "void", "crimson", "light", "vortex", "crypt", "oath", "wing", "draconic", "oblivion", "xeno"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for : .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game.init(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named:
            "Tree \(currentGame.incorrectMovesRemaining)")
    }
}

