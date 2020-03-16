//
//  ConstraintHelper.swift
//  HangmanTests
//
//  Created by René Pirringer on 11.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class ConstraintHelper {
	
	
	class func findContraint(inView view: UIView, firstAttribute: NSLayoutConstraint.Attribute, secondAttribute: NSLayoutConstraint.Attribute = .notAnAttribute) -> NSLayoutConstraint? {
		
		for constraint in view.constraints {
			NSLog("constraint.firstAttribute: \(constraint.firstAttribute.rawValue)")
			NSLog("constraint.secondAttribute: \(constraint.secondAttribute.rawValue)")

			NSLog("firstAttribute: \(firstAttribute.rawValue)")
			NSLog("secondAttribute: \(secondAttribute.rawValue)")

			if constraint.firstAttribute == firstAttribute && constraint.secondAttribute == secondAttribute {
				return constraint
			}
		}
		return nil
	}
	
	
	class func findContraint(inView view: UIView, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
		return findContraint(inView: view, firstAttribute: attribute, secondAttribute: attribute)
	}
	
	class func hasConstraint( forView view: UIView, withAttribute attribute: NSLayoutConstraint.Attribute,guide: UILayoutGuide? = nil) -> Bool {
		
		guard let superview = view.superview else {
			XCTFail("view was not added as superview")
			return false
		}
		
		guard let constraint = self.findContraint(inView: superview, attribute: attribute) else {
			XCTFail("constraint not present")
			return false
		}
		
		guard let firstView = constraint.firstItem as? UIView else {
			XCTFail("first item is not a UIView")
			return false
		}
		if firstView != view {
			return false
		}
		
		if let guide = guide {
			
			guard let secondGuide = constraint.secondItem as? UILayoutGuide else {
				XCTFail("secondItem is not a UILayoutGuide")
				return false
			}
			if guide != secondGuide {
				return false
			}
		} else {
		
			guard let secondView = constraint.secondItem as? UIView else {
				XCTFail("second item is not a UIView")
				return false
			}
		
			if secondView != view.superview {
				return false
			}
		}
		
		return true
		
	}
	
	class func hasConstraint(forView view: UIView,
													 withAttribute attribute: NSLayoutConstraint.Attribute,
													 value: CGFloat = 0,
													 secondAttribute: NSLayoutConstraint.Attribute = .notAnAttribute,
													 withView: UIView? = nil,
													 multiplier: CGFloat = 1.0, file: StaticString = #file, line: UInt = #line) -> Bool {

		var secondAttributeForSearch = secondAttribute
		var searchInView = view
		if let secondView = withView {
			searchInView = secondView
			secondAttributeForSearch = attribute
		}
		
		guard let constraint = self.findContraint(inView: searchInView, firstAttribute: attribute, secondAttribute: secondAttributeForSearch) else {
			XCTFail("constraint not present", file: file, line: line)
			return false
		}
		
	
		if constraint.constant == value &&
			constraint.relation == .equal &&
			Int(constraint.multiplier*1000) == Int(multiplier*1000) &&
			constraint.priority == .required {
			return true
		}

		return false
	}
	
}
