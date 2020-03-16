//
//  HangmanViewTest.swift
//  HangmanTests
//
//  Created by René Pirringer on 14.02.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
@testable import Hangman

class HangmanViewForTest: HangmanView {
	var setNeedsDisplayWasCalled = false
	
	override func setNeedsDisplay() {
		self.setNeedsDisplayWasCalled = true
	}
}

class HangmanViewTest : XCTestCase {
	
	var hangmanView: HangmanView!
	var drawFrame: CGRect?
	var drawAttempts: Int?

	override func setUp() {
		super.setUp()
		hangmanView = HangmanView()
		hangmanView.styleKitDrawHangman = self.drawHangman
	}
	
	func test_is_UIView() {
		// expect
		XCTAssertTrue(hangmanView as AnyObject is UIView)
	}
	

	@objc func drawHangman(frame: CGRect, resizing: HangmanStyleKit.ResizingBehavior, attempts: CGFloat) {
		drawFrame = frame
		drawAttempts = Int(attempts)
	}

	
	var defaultRect : CGRect {
		get {
			CGRect(origin: .zero, size: CGSize(width: 44, height: 44))
		}
	}
	
	func test_drawRect_calls_HangmanStyleKit_draw() {
		// given
		let rect = self.defaultRect

		// when
		hangmanView.draw(rect)

		// then
		XCTAssertEqual(drawFrame, rect)
	}
	
	func test_set_attempts_value_calls_HangmanStyleKit_with_proper_attempts() {
		// given
		hangmanView.failureAttempts = 10
		
		// when
		hangmanView.draw(self.defaultRect)
		
		// then
		XCTAssertEqual(drawAttempts, 10)
	}
	
	func test_when_attempts_are_set_setNeedsDisplay_is_called() {
		// given
		let hangmanView = HangmanViewForTest()
		// init also calls setNeedsDisplay so reset the value first
		hangmanView.setNeedsDisplayWasCalled = false

		// when
		hangmanView.failureAttempts = 2
		
		// then
		XCTAssertTrue(hangmanView.setNeedsDisplayWasCalled)
	}
	
	
	func test_has_default_background_color() {
		// given
		let hangmanView = HangmanViewForTest()

		// then
		XCTAssertEqualColor(hangmanView.backgroundColor, .systemBackground)
	}
	
	// when the device is rotated that the draw method must be triggered, otherwise the hangman looks ugly
	func test_setNeedsDisplay_is_called_on_layoutSubviews() {
		// given
		let hangmanView = HangmanViewForTest()
		// init also calls setNeedsDisplay so reset the value first
		hangmanView.setNeedsDisplayWasCalled = false

		// when
		hangmanView.layoutSubviews()
		
		// then
		XCTAssertTrue(hangmanView.setNeedsDisplayWasCalled)
	}
	
	
	
	
	func test_is_encodable() {
		// given
		let hangmanView = HangmanView()
		
		// when
		guard let result = encodeDecode(object: hangmanView) else {
			XCTFail("ButtonView is not encodable")
			return
		}
		
		// then
		XCTAssertEqualColor(result.backgroundColor, .systemBackground)
	}
	
	
}
