//
//  StringCharacterExtension.swift
//  Hangman
//
//  Created by René Pirringer on 02.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation


extension String {
	
	func character(at atIndex: Int) -> Character {
		let index = self.index(self.startIndex, offsetBy: atIndex)
		return self[index]
	}
	
}
