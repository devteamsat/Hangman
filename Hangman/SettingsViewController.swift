//
//  SettingsViewController.swift
//  Hangman
//
//  Created by René Pirringer on 09.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
	
	let creditsTitle = UILabel()
	let creditsText = UITextView()
	let supportButton = UIButton()

	override func loadView() {
		super.loadView()
		view.backgroundColor = .systemBackground
		
		creditsTitle.translatesAutoresizingMaskIntoConstraints = false
		creditsText.translatesAutoresizingMaskIntoConstraints = false
		supportButton.translatesAutoresizingMaskIntoConstraints = false

		creditsTitle.text = "Credits"
		creditsTitle.font = UIFont.preferredFont(forTextStyle: .title1)
		
		creditsText.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
		
		supportButton.setTitle("Support", for: .normal)
		
		self.view.addSubview(creditsTitle)
		self.view.addSubview(creditsText)
		self.view.addSubview(supportButton)
		
		creditsText.backgroundColor = .yellow
		
		supportButton.backgroundColor = .blue

		
		// Credits Title Layout
		view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: creditsTitle.topAnchor, constant: -16.0).isActive = true
		view.centerXAnchor.constraint(equalTo: creditsTitle.centerXAnchor).isActive = true
		
		// Credits Text Layout
		creditsText.topAnchor.constraint(equalTo: creditsTitle.bottomAnchor, constant: 16).isActive = true
		view.readableContentGuide.leadingAnchor.constraint(equalTo: creditsText.leadingAnchor).isActive = true
		view.readableContentGuide.trailingAnchor.constraint(equalTo: creditsText.trailingAnchor).isActive = true
		
		// Support Button Layout
		supportButton.topAnchor.constraint(equalTo: creditsText.bottomAnchor, constant: 16).isActive = true
		view.readableContentGuide.rightAnchor.constraint(equalTo: supportButton.rightAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: supportButton.bottomAnchor, constant: 44.0).isActive = true
		supportButton.heightAnchor.constraint(equalToConstant: 66.0).isActive = true
		supportButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

	}
	
	
	
}
