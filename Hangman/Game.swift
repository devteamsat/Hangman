//
//  Game.swift
//  Hangman
//
//  Created by René Pirringer on 02.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation


open class Game {
	
	static let placeHolderCharacter : Character = "🙈"

	
	public enum Status {
		case won
		case running
		case lost
	}
	
	public private(set) var status : Status = .running
	
	var numberOfFailedAttempts = 0
	
	var hint : String = ""
	
	var wordToGuess : String = ""
	
	init(wordToGuess: String) {
		self.wordToGuess = wordToGuess
		for _ in 0..<wordToGuess.count {
			hint += "\(Game.placeHolderCharacter)"
		}
	}
	
	open func guess(letter: Character) {
		
		if status == .won {
			return
		}
		
		var newHint = ""
		
		for (index, character) in wordToGuess.enumerated() {
			if character.uppercased() == letter.uppercased() {
				newHint += "\(character)"
			} else {
				newHint += "\(hint.character(at: index))"
			}
		}
		
		if hint == newHint {
			//failure attempt
			numberOfFailedAttempts += 1
		}
		
		hint = newHint
		
		if newHint.firstIndex(of: Game.placeHolderCharacter) == nil {
			status = .won
		}
		

		if numberOfFailedAttempts >= 11 {
			status = .lost
		}
	}
	
	
}
