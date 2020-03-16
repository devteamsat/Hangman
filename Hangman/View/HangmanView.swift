//
//  hangmanView.swift
//  Hangman
//
//  Created by René Pirringer on 11.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class HangmanView : UIView {
	
	lazy var styleKitDrawHangman: (CGRect, HangmanStyleKit.ResizingBehavior, CGFloat) -> Void = HangmanStyleKit.drawHangman
	
	var failureAttempts: Int = 0 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	init() {
		super.init(frame: .zero)
		self.backgroundColor = .systemBackground
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		self.styleKitDrawHangman(rect, .aspectFit, CGFloat(failureAttempts))
	}
	
	override func layoutSubviews() {
		// when the device is rotated that the draw method must be triggered, otherwise the hangman looks ugly
		setNeedsDisplay()
	}
	
}
