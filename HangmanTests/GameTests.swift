//
//  HangmanTests.swift
//  HangmanTests
//
//  Created by René Pirringer on 02.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import XCTest
@testable import Hangman

class GameTests: XCTestCase {

	
	override func setUp() {
	}
	
	
	override func tearDown() {
	}
	
	func test_game_status_is_running() {
		// when
		let game = Game(wordToGuess: "a")

		// then
		XCTAssertEqual(game.status, .running)
	}
	
	func test_status_is_not_running_if_word_was_guessed() {
		// given
		let game = Game(wordToGuess: "a")
		
		// when
		game.guess(letter: "a")
		
		// then
		XCTAssertEqual(game.status, .won)
	}
	
	
	func test_status_is_running_if_word_was_NOT_guessed() {
		// given
		let game = Game(wordToGuess: "a")
		
		// when
		game.guess(letter: "b")
		
		// then
		XCTAssertEqual(game.status, .running)
	}
	
	
	
	func test_status_is_won_when_correct_word_was_guessed_with_two_attempts() {
		// given
		let game = Game(wordToGuess: "ab")
		
		// when
		game.guess(letter: "b")
		game.guess(letter: "a")
		
		// then
		XCTAssertEqual(game.status, .won)
	}

	func test_status_is_lost_when_word_was_not_guessed_with_11_attempts() {
		// given
		let game = Game(wordToGuess: "a")
		
		// when
		for _ in 1...11 {
			game.guess(letter: "b")
		}
		
		//then
		XCTAssertEqual(game.status, .lost)
	}
	
	func test_status_is_running_when_word_was_not_guessed_with_10_attempts() {
		// given
		let game = Game(wordToGuess: "a")

		// when
		for _ in 1...10 {
			game.guess(letter: "b")
		}
		
		// then
		XCTAssertEqual(game.status, .running)
	}
	
	func test_status_is_not_lost_on_11_attempts_and_only_10_were_wrong() {
		// given
		let game = Game(wordToGuess: "ab")
		
		// when
		for _ in 1...11 {
			game.guess(letter: "b")
		}
		
		//then
		XCTAssertEqual(game.status, .running)
	}
	
	
	func test_status_is_lost_on_12_attempts_where_only_one_was_right() {
		// given
		let game = Game(wordToGuess: "ab")
		
		// when
		for _ in 1...12 {
			game.guess(letter: "b")
		}
		
		//then
		XCTAssertEqual(game.status, .lost)
	}
	
	
	
	
	func test_hint_string_has_one_letter_for_word_to_guess_A() {
		// given
		let game = Game(wordToGuess: "a")

		let expectedString = String(Game.placeHolderCharacter)
		// when & then
		XCTAssertEqual(game.hint, expectedString)
	}
	
	func test_hint_string_has_two_letter_for_word_to_guess_AB() {
		// given
		let game = Game(wordToGuess: "ab")

		let expectedString = "\(Game.placeHolderCharacter)\(Game.placeHolderCharacter)"
		// when & then
		XCTAssertEqual(game.hint, expectedString)
	}
	
	
	func test_guess_letter_shows_letter_in_hint_for_A() {
		// given
		let game = Game(wordToGuess: "a")

		// when
		game.guess(letter: "a")
		
		// then
		XCTAssertEqual(game.hint, "a")
		
	}
	
	
	func test_guess_letter_shows_letter_in_hint_for_ABBA() {
		// given
		let game = Game(wordToGuess: "abba")

		// when
		game.guess(letter: "a")
		let hint = game.hint
		
		// then
		XCTAssertEqual(hint.character(at:0), "a")
		XCTAssertEqual(hint.character(at:3), "a")
	}
	
	func test_guess_letter_shows_placeholder_for_not_guessed_letters_in_hint_for_ABBA() {
		// given
		let game = Game(wordToGuess: "abba")

		// when
		game.guess(letter: "a")
		let hint = game.hint

		// then
		XCTAssertEqual(hint.character(at:1), Game.placeHolderCharacter)
		XCTAssertEqual(hint.character(at:2), Game.placeHolderCharacter)
	}
	
	
	func test_guess_letter_ignores_case() {
		// given
		let game = Game(wordToGuess: "Abba")

		// when
		game.guess(letter: "A")
		let hint = game.hint


		// then
		XCTAssertEqual(hint.character(at:0), "A")
		XCTAssertEqual(hint.character(at:3), "a")

	}
	
	func test_is_won_additioal_guess_does_nothing() {
		// given
		let game = Game(wordToGuess: "Abba")

		// when
		game.guess(letter: "A")
		game.guess(letter: "B")
		game.guess(letter: "B")

		// then
		XCTAssertEqual(game.numberOfFailedAttempts, 0)
		
	}
	
	
	func doSomething() throws -> Int {
		throw NSError(domain: "", code: 1, userInfo: nil)
	}
	
	func testNoThrowImport() {
		XCTAssertNoThrow(self.doSomething)
	}

	func importFromJson() throws {
		let value = try self.doSomething()
		XCTAssertEqual(value, 10)
	}
	
	
}
