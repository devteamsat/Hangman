//
//  ButtonViewTest.swift
//  HangmanTests
//
//  Created by René Pirringer on 11.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest
@testable import Hangman

class ButtonViewTest: XCTestCase {
	

	
	func test_has_26_buttons() {
		// given
		let buttonView = ButtonView()
		
		// when & then
		assertThat(buttonView.buttons, hasCount(26))
	}
	
	func test_buttons_title_is_alphabet() {
		// given
		let buttonView = ButtonView()
		let alpabeth = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
		
		// when & then
		for (index, character) in alpabeth.enumerated() {
			let title = buttonView.buttons[index].title(for: .normal)
			assertThat(title?.count, presentAnd(equalTo(1)))
			assertThat(title?.first, presentAnd(equalTo(character)))
		}
	}
	
	func test_buttons_title_has_proper_font() {
		// given
		let buttonView = ButtonView()
		let expectedFont = UIFont.systemFont(ofSize: 20, weight: .heavy)

		// when & then
		
		for button in buttonView.buttons {
			assertThat(button.titleLabel?.font, presentAnd(equalTo(expectedFont)))
		}
		
	}
	
	func test_buttons_has_proper_background_color() {
		// given
		let buttonView = ButtonView()

		// when & then
		
		for button in buttonView.buttons {
			assertThat(button.backgroundColor, presentAnd(equalToColor(.systemGray3)))
		}
	}
	
	func test_buttons_has_proper_background_color_when_highlighed() {
		// given
		let buttonView = ButtonView()

		for button in buttonView.buttons {
			// when
			button.isHighlighted = true
			
			// then
			assertThat(button.backgroundColor, presentAnd(equalToColor(.systemGray)))
		}
	}
	
	func test_buttons_has_proper_background_color_when_highlighed_disabled() {
		// given
		let buttonView = ButtonView()

		for button in buttonView.buttons {
			// when
			button.isHighlighted = true
			button.isHighlighted = false
			
			// then
			assertThat(button.backgroundColor, presentAnd(equalToColor(.systemGray3)))
		}
	}
	
	
	func test_buttons_has_proper_text_color() {
		// given
		let buttonView = ButtonView()

		// when & then
		
		for button in buttonView.buttons {
			assertThat(button.titleColor(for: .normal), presentAnd(equalToColor(.label)))
		}
	}
	
	
	
	func test_has_contentView() {
		// when
		let buttonView = ButtonView()
		
		// then
		assertThat(buttonView.subviews, hasCount(1))
		assertThat(buttonView.subviews.first, presentAnd(sameInstance(buttonView.contentView)))
	}
	
	func test_has_contentView_has_proper_layout() {
		// when
		let buttonView = ButtonView()
		
		// then
		assertThat(buttonView.contentView.translatesAutoresizingMaskIntoConstraints, equalTo(false))
		assertThat(ConstraintHelper.hasConstraint(forView: buttonView.contentView, withAttribute: .leading), equalTo(true))
		assertThat(ConstraintHelper.hasConstraint(forView: buttonView.contentView, withAttribute: .trailing), equalTo(true))
		assertThat(ConstraintHelper.hasConstraint(forView: buttonView.contentView, withAttribute: .bottom), equalTo(true))
		assertThat(ConstraintHelper.hasConstraint(forView: buttonView.contentView, withAttribute: .top), equalTo(true))
		assertThat(Float(buttonView.contentView.spacing), closeTo(10, 0.001))
	}
	

	func test_has_contentView_layout_axis_is_vertical() {
		// when
		let buttonView = ButtonView()
		
		// then
		assertThat(buttonView.contentView.axis, equalTo(.vertical))
	}
	
	
	func test_has_contentView_with_three_button_row_subview() {
		// when
		let buttonView = ButtonView()
		
		// then
		assertThat(buttonView.contentView.subviews, hasCount(greaterThanOrEqualTo(3)))
		assertThat(buttonView.contentView.subviews, everyItem(instanceOf(UIStackView.self)))
	}
	
	func test_button_rows_has_proper_layout() {
		// when
		let buttonView = ButtonView()
		
		// then
		for view in buttonView.contentView.subviews {
			guard let stackView = view as? UIStackView else {
				XCTFail("UIStackView expected")
				return
			}
			assertThat(stackView.axis, equalTo(.horizontal))
			assertThat(stackView.distribution, equalTo(.equalCentering))
		}
		
		
	}
	
	func test_buttons_a_to_i_are_in_the_firare_added_as_subview() {
		// when
		let buttonView = ButtonView()
		
		// then
		let row = buttonView.contentView.subviews[0]
		assertThat(row.subviews, hasCount(9))

		for (index, character) in "ABCDEFGHI".enumerated() {
			guard let button = row.subviews[index] as? HighlightButton else {
				XCTFail("HighlightButton expected")
				return
			}
			assertThat(button.title(for: .normal), equalTo(String(character)))
		}
	}
	

	func test_buttons_J_to_R_are_in_the_firare_added_as_subview() {
		// when
		let buttonView = ButtonView()
		
		// then
		let row = buttonView.contentView.subviews[1]
		assertThat(row.subviews, hasCount(9))

		for (index, character) in "JKLMNOPQR".enumerated() {
			guard let button = row.subviews[index] as? HighlightButton else {
				XCTFail("HighlightButton expected")
				return
			}
			assertThat(button.title(for: .normal), equalTo(String(character)))
		}
	}
	
	func test_buttons_S_to_Z_are_in_the_firare_added_as_subview() {
		// when
		let buttonView = ButtonView()
		
		// then
		let row = buttonView.contentView.subviews[2]
		assertThat(row.subviews, hasCount(greaterThanOrEqualTo(8)))

		for (index, character) in "STUVWXYZ".enumerated() {
			guard let button = row.subviews[index] as? HighlightButton else {
				XCTFail("HighlightButton expected")
				return
			}
			assertThat(button.title(for: .normal), equalTo(String(character)))
		}
	}
	
	func test_last_button_row_has_spacer_view_at_the_end_so_that_every_row_has_9_columns() {
		// when
		let buttonView = ButtonView()
		
		// then
		let row = buttonView.contentView.subviews[2]
		assertThat(row.subviews, hasCount(9))
		assertThat(row.subviews.last, presentAnd(not(instanceOf(HighlightButton.self))))
	}
	
	func test_spacer_view_has_proper_layout() {
		// when
		let buttonView = ButtonView()
		
		// then
		guard let row = buttonView.contentView.subviews[2] as? UIStackView else {
			XCTFail("row not present")
			return
		}
		assertThat(row.subviews, hasCount(9))
		guard let spacerView = row.subviews.last else {
			XCTFail("spacerView expected")
			return
		}
		assertThat(ConstraintHelper.hasConstraint(forView: spacerView, withAttribute: .height, value: 50.0), equalTo(true))
		assertThat(ConstraintHelper.hasConstraint(forView: spacerView, withAttribute: .width, withView: spacerView.superview, multiplier: 0.1), equalTo(true))
	}
	
	
	func test_buttons_have_proper_layout() {
		// when
		let buttonView = ButtonView()
		
		// then
		
		for button in buttonView.buttons {
			assertThat(ConstraintHelper.hasConstraint(forView: button, withAttribute: .height, value: 50.0), equalTo(true))
			assertThat(ConstraintHelper.hasConstraint(forView: button, withAttribute: .width, withView: button.superview, multiplier: 0.1), equalTo(true))
		}
	}
	
	
	func test_press_A_button_calls_closure_with_A_character() {
		// given
		var receivedCharacter : Character?
		let buttonView = ButtonView()
		buttonView.buttonPressedClosure = { character in
			receivedCharacter = character
		}
		
		// when
		buttonView.buttons.first?.tap()
		
		
		// then
		assertThat(receivedCharacter, equalTo("A"))
	}
	
	func test_button_pressed_calls_closure_with_proper_character() {
		// given
		var receivedCharacter : Character?
		let buttonView = ButtonView()
		buttonView.buttonPressedClosure = { character in
			receivedCharacter = character
		}
		let alpabeth = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
		
		// when & then
		for (index, character) in alpabeth.enumerated() {
			// when
			buttonView.buttons[index].tap()
			
			// then
			assertThat(receivedCharacter, equalTo(character))
		}
	}
	
	
	func test_is_encodable() {
		// given
		let buttonView = ButtonView()
		
		// when
		guard let result = encodeDecode(object: buttonView) else {
			XCTFail("ButtonView is not encodable")
			return
		}
		
		// then
		assertThat(result.contentView.subviews, hasCount(3))
		assertThat(result.contentView.subviews, everyItem(instanceOf(UIStackView.self)))
	}
	
}
