//
//  GameFAke.swift
//  HangmanTests
//
//  Created by René Pirringer on 13.02.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
@testable import Hangman


class GameFake: Game {
	
	var guessedLetter : Character?
	
	var fakeStatus : Status = .running
	
	override var status : Status {
		get {
			fakeStatus
		}
	}
	
	override func guess(letter: Character) {
		guessedLetter = letter
	}
}
