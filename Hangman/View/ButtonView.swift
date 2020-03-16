//
//  ButtonView.swift
//  Hangman
//
//  Created by René Pirringer on 11.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class ButtonView : UIView {
	
	typealias ButtonPressedClosure = (Character) -> (Void)
	
	let buttons : [UIButton] = {
		var result = [UIButton]()
		
		let alpabeth = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
		let boldFont = UIFont.systemFont(ofSize: 20, weight: .heavy)

		// when & then
		for (index, character) in alpabeth.enumerated() {
			let button = HighlightButton()
			button.setTitle(String(character), for: .normal)
			button.titleLabel?.font = boldFont
			button.setTitleColor(.label, for: .normal)
			button.setBackgroundColor(.systemGray3, state: .normal)
			button.setBackgroundColor(.systemGray, state: .highlighted)
			result.append(button)
			button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
		}
		return result
	}()
	
	let contentView = UIStackView()
	
	var buttonPressedClosure : ButtonPressedClosure?
	
	public init() {
		super.init(frame: .zero)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initialize()
	}
	
	func initialize() {
		self.addSubview(contentView)
		
		let rows = [
			UIStackView(),
			UIStackView(),
			UIStackView()
		]

		contentView.spacing = 10.0

		let numberItemsInRow = 9
		for (index, row) in rows.enumerated() {
			contentView.addArrangedSubview(row)
			
			let startIndex = index*numberItemsInRow
			var endIndex = startIndex+numberItemsInRow
			if endIndex > buttons.count {
				endIndex = buttons.count
			}
			row.distribution = .equalCentering
			row.axis = .horizontal

			for i in startIndex..<endIndex {
				let button = buttons[i]
				row.addArrangedSubview(button)
				button.heightAnchor.constraint(equalToConstant: 50).isActive = true
				button.widthAnchor.constraint(equalTo: row.widthAnchor, multiplier: 0.1).isActive = true
			}
			
		}
		
		// add a view to the last row, so that every row has 9 items
		let spacerView = UIView()
		if let lastRow = rows.last {
			lastRow.addArrangedSubview(spacerView)
			spacerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
			spacerView.widthAnchor.constraint(equalTo: lastRow.widthAnchor, multiplier: 0.1).isActive = true
		}

		
		contentView.translatesAutoresizingMaskIntoConstraints = false;
		contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		contentView.axis = .vertical
		
	}
	
	
	@objc
	func buttonPressed(_ sender: Any?) {
		guard let button = sender as? UIButton else {
			return
		}
		guard let title = button.title(for: .normal) else {
			return
		}
		guard let character = Array(title).first else {
			return
		}
		self.buttonPressedClosure?(character)
	}
}
