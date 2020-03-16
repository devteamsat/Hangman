//
//  HighlightButtonTest.swift
//  HangmanTests
//
//  Created by René Pirringer on 14.02.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
@testable import Hangman

class HighlightButtonTest: XCTestCase {
	
	
	func test_HighlightButton_is_UIButton() {
		// when
		let button = HighlightButton()
		
		// then (as UIView surpressed the compiler warning)
		XCTAssertTrue(button as UIView is UIButton)
	}
	
	func test_HighlightButton_background_color_shows_normal_backgroundColor() {
		// given
		let button = HighlightButton()
		
		//when
		button.setBackgroundColor(.red, state: .normal)
		
		// then
		XCTAssertEqualColor(button.backgroundColor, .red)
	}
	
	func test_HighlightButton_background_color_shows_highlight_backgroundColor_when_highlighted() {
		// given
		let button = HighlightButton()
		
		//when
		button.setBackgroundColor(.blue, state: .highlighted)
		button.isHighlighted = true
		
		// then
		XCTAssertEqualColor(button.backgroundColor, .blue)
	}
	
	func test_HighlightButton_toggle_background_colors() {
		// given
		let button = HighlightButton()
		
		// then
		button.setBackgroundColor(.red, state: .normal)
		button.setBackgroundColor(.blue, state: .highlighted)

		
		// then
		XCTAssertEqualColor(button.backgroundColor, .red)
		button.isHighlighted = true
		XCTAssertEqualColor(button.backgroundColor, .blue)
		button.isHighlighted = false
		XCTAssertEqualColor(button.backgroundColor, .red)
	}
	
}
