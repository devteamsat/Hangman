//
//  ViewController.swift
//  Hangman
//
//  Created by René Pirringer on 02.01.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var game = Game(wordToGuess: "secret")
	
	let contentView = UIStackView()
	
	let hintView = UITextView()
	let hangmanView = HangmanView()
	let buttonView = ButtonView()
	let actionView = UIView()
	let restartButton = HighlightButton()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Hangman"
		let gearImage = UIImage(systemName: "gear")
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: gearImage, style:.plain, target: self, action: #selector(settingsButtonPressed))
		
		contentView.addArrangedSubview(hintView)
		contentView.addArrangedSubview(actionView)
		contentView.addArrangedSubview(hangmanView)
		contentView.addArrangedSubview(buttonView)

		
		contentView.distribution = .fill
		contentView.axis = .vertical
		
		hintView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		hintView.text = game.hint
		hintView.textAlignment = .center
		hintView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		hintView.isEditable = false
		hintView.isSelectable = false

		actionView.addSubview(restartButton)
		restartButton.setBackgroundColor(.systemBlue, state: .normal)
		restartButton.setBackgroundColor(.systemGray, state: .highlighted)
		restartButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
		restartButton.setTitle("Restart Game", for: .normal)
		restartButton.layer.cornerRadius = 8
		restartButton.isHidden = true
		restartButton.addTarget(self, action: #selector(restartPressed), for: .touchUpInside)

		buttonView.buttonPressedClosure = { [weak self] letter in
			self?.performGuess(letter: letter)
		}
		
		self.view.addSubview(self.contentView)

		contentView.translatesAutoresizingMaskIntoConstraints = false

		contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		

		restartButton.translatesAutoresizingMaskIntoConstraints = false
		restartButton.topAnchor.constraint(equalTo: actionView.topAnchor).isActive = true
		restartButton.bottomAnchor.constraint(equalTo: actionView.bottomAnchor).isActive = true
		restartButton.centerXAnchor.constraint(equalTo: actionView.centerXAnchor).isActive = true
	}
	
	
	func performGuess(letter: Character) {
		self.game.guess(letter: letter)
		updateContent()

	}
	

	@objc
	func restartPressed() {
		game = Game(wordToGuess: "secret")
		updateContent()
	}
	
	func updateContent() {
		self.hangmanView.failureAttempts = self.game.numberOfFailedAttempts
		
		switch game.status {
			case .won:
			self.hintView.text = "You are a winner!"
			self.hintView.textColor = .systemGreen
			self.restartButton.isHidden = false
		case .lost:
			self.hintView.text = "You have lost!"
			self.hintView.textColor = .systemRed
			self.restartButton.isHidden = false
		default:
			self.hintView.text = self.game.hint
			self.hintView.textColor = .label
			self.restartButton.isHidden = true
			break
		}
	}

	
	@objc
	func settingsButtonPressed() {
		let settingsViewController = SettingsViewController()
		self.navigationController?.pushViewController(settingsViewController, animated: true)
	}
}

