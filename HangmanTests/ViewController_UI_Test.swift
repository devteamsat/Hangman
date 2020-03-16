//
//  ViewController_UI_Test.swift
//  HangmanTests
//
//  Created by René Pirringer on 09.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//


import UIKit
import XCTest
import Hamcrest
@testable import Hangman

class ViewController_UI_Test: XCTestCase {

	
	func loadViewControllerFromStoryboard(file: StaticString = #file, line: UInt = #line) -> ViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController {
			if let viewController = navigationController.viewControllers.first as? ViewController {
				return viewController
			}
		}
		XCTFail("cannot load ViewController", file: file, line: line)
		// make the compiler happy
		return ViewController()
	}
	
	func test_navigationBar_shows_hangman_title() {
		// given
		let viewController = loadViewControllerFromStoryboard()

		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.navigationItem.title, equalTo("Hangman"))
	}
	
	
	func test_has_settings_barButton_item_in_the_navigationBar() {
		// given
		let viewController = loadViewControllerFromStoryboard()

		// when
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.navigationItem.rightBarButtonItem, present())
	}
	
	
	func test_settings_barButton_has_settings_icon() {
		// given
		let viewController = loadViewControllerFromStoryboard()

		// when
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.navigationItem.rightBarButtonItem?.image, presentAnd(equalToSystemImage("gear")))
	}
	
	func equalToSystemImage(_ name: String) -> Matcher<UIImage> {
		return Matcher("file exists at file URL") { (value) -> MatchResult in
			if let imageAsset = value.value(forKey: "_imageAsset") as? UIImageAsset {
				if let name = imageAsset.value(forKey: "_assetName") as? String {
					if name == name {
						return .match
					}
				}
			}
			 return .mismatch("Image is not a system image with name \(name): \(value)")
		 }
	}
	
	
	func test_settings_barButton_is_tapped_shows_SettingsViewController() {
		// given
		let viewController = loadViewControllerFromStoryboard()
		let navigationController = TestNavigationController(rootViewController: viewController)
		navigationController.loadViewIfNeeded()

		// when
		viewController.navigationItem.rightBarButtonItem?.tap()
		
		// then
		assertThat(navigationController.viewControllers, hasCount(2))
		assertThat(navigationController.viewControllers.last, presentAnd(instanceOf(SettingsViewController.self)))
	}
	
}
