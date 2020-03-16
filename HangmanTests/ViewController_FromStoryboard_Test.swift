//
//  AppDelegateTest.swift
//  HangmanTests
//
//  Created by René Pirringer on 04.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import UIKit
import XCTest
import Hamcrest
@testable import Hangman

class ViewController_FromStoryboard_Test: XCTestCase {


	func test_has_rootViewController() {
		// given
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		// when
		let viewController = storyboard.instantiateInitialViewController()
		
		// expect
		assertThat(viewController, present())
	}
	
	func test_rootViewController_is_NavigationController() {
		// given
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		// when
		let viewController = storyboard.instantiateInitialViewController()
		
		// then
		assertThat(viewController, presentAnd(instanceOf(UINavigationController.self)))
	}
	
	
	func test_navigationController_has_ViewController_as_first_viewController() {
		// given
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		// when
		let viewController = storyboard.instantiateInitialViewController()
		
		
		// then
		guard let navigationController = viewController as? UINavigationController else {
			XCTFail("UINavigationController expected")
			return
		}
		assertThat(navigationController.viewControllers.first, presentAnd(instanceOf(ViewController.self)))
	}
	

}
