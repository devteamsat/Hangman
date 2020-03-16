//
//  UIButtonActionExtension.swift
//  HangmanTests
//
//  Created by René Pirringer on 13.02.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {

	func tap() {
		self.sendActions(for: .touchUpInside)
	}
}
