//
//  ColorHelper.swift
//  HangmanTests
//
//  Created by René Pirringer on 07.02.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import XCTest


func XCTAssertEqualColor(_ first: UIColor?, _ second: UIColor?, file: StaticString = #file, line: UInt = #line) {
	
	
	guard let first = first else {
		XCTFail("first color is not present", file:file, line:line)
		return
	}

	guard let second = second else {
		XCTFail("second color is not present", file:file, line:line)
		return
	}

	if ColorHelper.compare(first: first, second: second) {
		return
	}
	
	
	XCTFail("color \(ColorHelper.rgbString(color:second)) is not equal to : \(ColorHelper.rgbString(color:first))", file: file, line: line)

	
}


class ColorHelper {

	
	public class func compare(first: UIColor, second: UIColor) -> Bool {
		
		var firstRed: CGFloat = 0
		var firstGreen: CGFloat = 0
		var firstBlue: CGFloat = 0
		var firstAlpha: CGFloat = 0
		var secondRed: CGFloat = 0
		var secondGreen: CGFloat = 0
		var secondBlue: CGFloat = 0
		var secondAlpha: CGFloat = 0
		
		first.getRed(&firstRed, green: &firstGreen, blue: &firstBlue, alpha: &firstAlpha);
		second.getRed(&secondRed, green: &secondGreen, blue: &secondBlue, alpha: &secondAlpha);
		
		if areEqualFloat(firstRed, secondRed) &&
			areEqualFloat(firstGreen, secondGreen) &&
			areEqualFloat(firstBlue, secondBlue) &&
			areEqualFloat(firstAlpha, secondAlpha) {
			return true
		}
		
		NSLog("color \(rgbString(color:second)) is not equal to : \(rgbString(color:first))")
		return false
		
	}
	
	
	class func areEqualFloat(_ first: CGFloat, _ second: CGFloat) -> Bool {
		return Int(round(first * 255)) == Int(round(second * 255))
	}
	
	class func rgbString(color: UIColor) -> String {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
		
		var result = "UIColor(red: \(Int(red*255))"
		result += ", green: \(Int(green*255))"
		result += ", blue: \(Int(blue*255))"
		
		result += String(format:", alpha %.2f)", alpha)
		
		return result
		
	}
	
}
