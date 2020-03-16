//
//  HighlightButton.swift
//  Hangman
//
//  Created by René Pirringer on 14.02.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class HighlightButton : UIButton {
	
	var backgroundColorForState = [UInt:UIColor]()
	
	
	func setBackgroundColor(_ color: UIColor, state: State) {
		self.backgroundColorForState[state.rawValue] = color
		self.setBackgroundColor(state: self.state)
	}
	
	override var isHighlighted: Bool {
		didSet {
			if isHighlighted {
				setBackgroundColor(state: .highlighted)
			} else {
				setBackgroundColor(state: .normal)
			}
		}
	}
	
	func setBackgroundColor(state: State) {
		if let color = backgroundColorForState[state.rawValue] {
			self.backgroundColor = color
		}
	}
	
	
}
