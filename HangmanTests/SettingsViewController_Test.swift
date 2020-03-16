//
//  SettingsViewController_Test.swift
//  HangmanTests
//
//  Created by René Pirringer on 09.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers
@testable import Hangman

class SettingsViewControllerTest: XCTestCase {
	
	var viewController: SettingsViewController!
	
	override func setUp() {
		super.setUp()
		
		// given
		viewController = SettingsViewController(nibName: nil, bundle: nil)
	}
	
	override func tearDown() {
		viewController = nil
		super.tearDown()
	}
	
	
	func test_has_has_system_background_color() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.view.backgroundColor, presentAnd(equalToColor(.systemBackground)))
	}
	
	
	// MARK: Credits Title
	
	func test_has_credits_title_label() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsTitle, presentAnd(instanceOf(UILabel.self)))
	}
	
	
	func test_credits_title_label_has_proper_title() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsTitle.text, equalTo("Credits"))
	}
	
	func test_credits_title_label_was_added_as_subview() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsTitle.superview, presentAnd(equalTo(viewController.view)))
	}

	func test_credits_title_label_uses_autolayout_contraints() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsTitle.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
	func test_credits_title_label_uses_title_font() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		let expectedFont = UIFont.preferredFont(forTextStyle: .title1)
		assertThat(viewController.creditsTitle.font, equalTo(expectedFont))
	}
	
	func test_credits_title_label_is_layout_is_top_center() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsTitle, isPinnedToSafeAreaAnchor(.top, gap: 16))
		assertThat(viewController.creditsTitle, isHorizontalCenter())
	}
	
	
	// MARK: - Credits Text
	
	func test_has_credits_text_view() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsText, presentAnd(instanceOf(UITextView.self)))
	}
	
	func test_has_credits_text_uses_autolayout_contraints() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsText.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
	func test_credits_title_label_has_text() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		let expectedText = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
		assertThat(viewController.creditsText.text, equalTo(expectedText))
	}
	
	
	func test_credits_text_was_added_as_subview() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsText.superview, presentAnd(equalTo(viewController.view)))
	}
	
	
	func test_credits_text_has_proper_layout() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.creditsText, isPinned(.top, toView: viewController.creditsTitle, gap: 16))
		assertThat(viewController.creditsText, isPinnedToReadableAnchor(.leading))
		assertThat(viewController.creditsText, isPinnedToReadableAnchor(.trailing))
	}
	
	
	// MARK: - Support Button
	
	func test_has_support_button() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.supportButton, presentAnd(instanceOf(UIButton.self)))
	}
	
	func test_has_support_button_has_blue_background() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.supportButton.backgroundColor, presentAnd(equalToColor(.blue)))
	}
	
	func test_has_support_button_uses_autolayout_contraints() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.supportButton.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
	func test_has_support_button_has_proper_title() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.supportButton.title(for: .normal), equalTo("Support"))
	}
	
	
	func test_has_support_button_was_added_as_subview() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.supportButton.superview, presentAnd(equalTo(viewController.view)))
	}
	
	func test_has_support_button_has_proper_layout() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.supportButton, isPinnedToReadableAnchor(.right))
		assertThat(viewController.supportButton, isPinned(.bottom, gap: 44.0))
		assertThat(viewController.supportButton, isPinned(.top, toView:viewController.creditsText, gap: 16.0))
		assertThat(viewController.supportButton, hasHeight(of: 66.0))
	}
	
}
