//
//  UIBarButtonItemActionExtension.swift
//  HangmanTests
//
//  Created by René Pirringer on 09.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
	
	func tap() {
			if let target = self.target as? NSObject {
				target.perform(self.action, with: self)
			}
	}
}
