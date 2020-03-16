//
//  ViewControllerTest.swift
//  HangmanTests
//
//  Created by René Pirringer on 02.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
@testable import Hangman

class ViewControllerTest: XCTestCase {
	
	var viewController: ViewController!
	
	override func setUp() {
		super.setUp()
		
		// given
		viewController = ViewController(nibName: nil, bundle: nil)
		viewController.game = Game(wordToGuess: "foo")
		
	}
	
	override func tearDown() {
		viewController = nil
		super.tearDown()
	}
	

	
	func test_stackView_was_added_to_view() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.contentView.superview, viewController.view)
	}
	
	
	func test_stackView_layout_is_vertical() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.contentView.axis, .vertical)
	}
	
	func test_stackView_distribution_is_fill() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.contentView.distribution, .fill)
	}
	
	func test_stackView_uses_autoLayout() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertFalse(viewController.contentView.translatesAutoresizingMaskIntoConstraints)
	}
	
	
	
	
	func test_stackView_leadingAnchor_constraint_is_active() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.contentView, withAttribute: .leading))
	}
	
	func test_stackView_trailingAnchor_constraint_is_active() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.contentView, withAttribute: .trailing))
	}
	

	func test_stackView_topAnchor_constraint_is_active() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.contentView, withAttribute: .top, guide: viewController.view.safeAreaLayoutGuide))
	}
	

	func test_stackView_bottomAnchor_constraint_is_active() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.contentView, withAttribute: .bottom, guide: viewController.view.safeAreaLayoutGuide))
	}

	// MARK: - hint view
	
	func test_hintView_shows_hint() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertEqual(viewController.hintView.text, viewController.game.hint)
	}
	
	func test_hintView_text_is_center() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertEqual(viewController.hintView.textAlignment, .center)
	}
	
	func test_hintView_text_has_proper_font() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		let expectedFont = UIFont.systemFont(ofSize: 20, weight: .regular)
		XCTAssertEqual(viewController.hintView.font, expectedFont)
	}
	
	func test_hintView_was_added_as_subview() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.hintView.superview, viewController.contentView)
	}
	
	func test_hintView_is_first_view_in_the_stackView() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.contentView.arrangedSubviews.first, viewController.hintView)
	}
	
	func test_hintView_has_proper_height() {
		
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.hintView, withAttribute: .height, value: 44.0))
	}
	
	func test_hintView_is_not_editable() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertFalse(viewController.hintView.isEditable)
	}
	
	func test_hintView_is_not_selectable() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertFalse(viewController.hintView.isSelectable)
	}
	
	
	// MARK: - Hangman View
	
	func test_hangmanView_has_proper_type() {
		// when
		viewController.loadViewIfNeeded()

		// then
		// I first write the XCTAssert as `XCTAssert(viewController.hangmanView is HangmanView)`
		// and the run the code and updated the ViewController compile, and then to pass
		// Because the hangmanView is a let I get a warning and I have solved this with:
		XCTAssert(viewController.hangmanView as UIView is HangmanView)
		// This is not a beautiful way, but I don't want to delete the test.
		// If sometime in the future anyone changes the type of the hangmanView I want to have
		// a test to verify this, and test should also be updated if it is a valid test
		
		// I for myself use SwiftHamcrest and the verification looks much nicer there:
		// assertThat(viewCOntroller.hangmanView, instanceOf(HangmanView.self))
	}
	
	func test_hangmanView_was_added_as_subview() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.hangmanView.superview, viewController.contentView)
	}
	
	
	func test_button_pressed_with_wrong_letter_updates_the_failure_attempt_on_hangmanView() {
		// given
		viewController.loadViewIfNeeded()

		// when
		viewController.buttonView.buttonPressedClosure?("A")
		
		// then
		XCTAssertEqual(viewController.hangmanView.failureAttempts, 1)
	}
	
	
	// MARK: - button view
	
	
	func test_buttonView_has_proper_type() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssert(viewController.buttonView as UIView is ButtonView)
	}
	
	func test_buttonView_was_added_as_subview() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.buttonView.superview, viewController.contentView)
	}
	
	func test_buttonView_is_last_view_in_the_stackView() {
		// when
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.contentView.arrangedSubviews.last, viewController.buttonView)
	}
	
	func test_buttonView_closure_is_present() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertNotNil(viewController.buttonView.buttonPressedClosure)
	}
	
	func test_buttonView_closure_executed_calls_game_guess() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()
		
		// when
		viewController.buttonView.buttonPressedClosure?("A")
		
		// then
		XCTAssertEqual(game.guessedLetter, "A")
	}
	
	func test_buttonView_closure_executed_updates_hint() {
		// given
		viewController.loadViewIfNeeded()

		// when
		viewController.buttonView.buttonPressedClosure?("O")
		
		// then
		XCTAssertEqual(viewController.game.hint, "🙈oo")
		XCTAssertEqual(viewController.hintView.text, "🙈oo")
	}
	
	
	// status message
	
	
	
	func test_game_is_won_shows_win_message_in_hintView() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()

		// when
		game.fakeStatus = .won
		viewController.buttonView.buttonPressedClosure?("O")
		
		// then
		XCTAssertEqual(viewController.hintView.text, "You are a winner!")
	}
	
	func test_game_is_won_shows_win_message_proper_color() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()

		// when
		game.fakeStatus = .won
		viewController.buttonView.buttonPressedClosure?("O")
		
		// then
		XCTAssertEqualColor(viewController.hintView.textColor, .systemGreen)
	}
	
	
	
	func test_game_is_lost_shows_hintView_with_proper_message() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()

		// when
		game.fakeStatus = .lost
		viewController.buttonView.buttonPressedClosure?("O")
		
		// then
		XCTAssertEqual(viewController.hintView.text, "You have lost!")
	}
	
	
	func test_game_is_lost_shows_hintView_with_proper_message_with_proper_color() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()

		// when
		game.fakeStatus = .lost
		viewController.buttonView.buttonPressedClosure?("O")
		
		// then
		XCTAssertEqualColor(viewController.hintView.textColor, .systemRed)
	}
	
	// Restart Button View
	
	
	func test_has_action_view() {
		// given
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(viewController.actionView as AnyObject is UIView)
	}
	
	
	func test_actionView_was_added_as_second_view_into_the_contentView() {
		// given
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertEqual(viewController.contentView.arrangedSubviews[1], viewController.actionView)
	}
	
	
	func test_has_restart_button() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(viewController.restartButton as UIButton is HighlightButton)
	}

	func test_has_restart_button_was_added_to_actionView() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertEqual(viewController.restartButton.superview, viewController.actionView)
	}

	func test_restart_button_has_proper_layout() {
		// when
		viewController.loadViewIfNeeded()

		// then
		
		XCTAssertFalse(viewController.restartButton.translatesAutoresizingMaskIntoConstraints)
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.restartButton, withAttribute: .centerX))
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.restartButton, withAttribute: .top))
		XCTAssertTrue(ConstraintHelper.hasConstraint(forView: viewController.restartButton, withAttribute: .bottom))

	}
	
	
	func test_restart_button_has_proper_title() {
		// given
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertEqual(viewController.restartButton.title(for: .normal), "Restart Game")
	}

	
	func test_restart_button_title_has_insets() {
		// given
		viewController.loadViewIfNeeded()

		// then
		XCTAssertEqual(viewController.restartButton.contentEdgeInsets.left, 16)
		XCTAssertEqual(viewController.restartButton.contentEdgeInsets.right, 16)
		XCTAssertEqual(viewController.restartButton.contentEdgeInsets.top, 6)
		XCTAssertEqual(viewController.restartButton.contentEdgeInsets.bottom, 6)
	}
	
	func test_restart_button_has_round_colors() {
		// given
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertEqual(viewController.restartButton.layer.cornerRadius, 8	)
	}
	

	func test_restart_button_has_proper_background_color() {
		// given
		viewController.loadViewIfNeeded()
		
		// when
		
		// then
		XCTAssertEqualColor(viewController.restartButton.backgroundColor, .systemBlue)
	}
	
	func test_restart_button_has_proper_highlight_color() {
		// given
		viewController.loadViewIfNeeded()
		
		// when
		viewController.restartButton.isHighlighted = true
		
		// then
		XCTAssertEqualColor(viewController.restartButton.backgroundColor, .systemGray)
	}

	
	func test_restartButton_is_hidden_when_game_is_running() {
		// given
		viewController.loadViewIfNeeded()
		
		// then
		XCTAssertTrue(viewController.restartButton.isHidden)
	}
	
	
	func test_game_is_won_shows_restart_button() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()

		// when
		game.fakeStatus = .won
		viewController.buttonView.buttonPressedClosure?("O")

		
		// then
		XCTAssertFalse(viewController.restartButton.isHidden)
	}
	
	func test_game_is_lost_shows_restart_button() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()

		// when
		game.fakeStatus = .lost
		viewController.buttonView.buttonPressedClosure?("O")

		
		// then
		XCTAssertFalse(viewController.restartButton.isHidden)
	}
	
	
	func test_restart_tapped_starts_new_game() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()
		
		// given
		viewController.restartButton.tap()
		
		// then
		XCTAssertFalse(viewController.game === game)
	}
	
	
	func test_restart_tapped_starts_new_game_and_sets_hintView_text() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()
		
		// given
		viewController.hintView.text = "asdf"
		viewController.restartButton.tap()

		// then
		XCTAssertEqual(viewController.hintView.text, "🙈🙈🙈🙈🙈🙈")
	}
	
	func test_restart_tapped_starts_new_game_and_sets_hintView_textColor() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()
		
		// given
		viewController.hintView.textColor = .red
		viewController.restartButton.tap()

		// then
		XCTAssertEqualColor(viewController.hintView.textColor, .label)
	}
	
	
	func test_restart_tapped_starts_new_game_and_hides_restart_button() {
		// given
		let game = GameFake(wordToGuess: "FOOBAR")
		viewController.game = game
		viewController.loadViewIfNeeded()
		
		// given
		viewController.restartButton.isHidden = false
		viewController.restartButton.tap()

		// then
		XCTAssertTrue(viewController.restartButton.isHidden)
	}

	
	
	
}
