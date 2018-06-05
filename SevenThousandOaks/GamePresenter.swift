//
//  GamePresenter.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension GamePresenter: PresenterProtocol {
	var wornCloset: FZWornCloset { return worn_closet }
	
	func populateView(with oaksFelled: Int) {
		guard let gameViewController = view_controller else { return }
		worn_closet.getPresenterEntities(by: key_ring.key)?.set(oaksFelled, by: oak_count_key)
		let
		totalOaksToFell = Consts.totalOaksToFell,
		gameOver = oaksFelled >= totalOaksToFell,
		oakText = oaksFelled == 1 ? "oak" : "oaks"
		gameViewController.feedbackLabel.text = !gameOver ? "You have felled \(oaksFelled) \(oakText)." : "Congrats, you felled all \(totalOaksToFell) oaks!"
	}

	func postViewActivated() {
		guard let gameViewController = view_controller else { return }
		gameViewController.completionLabel.makeWrappable()
		gameViewController.completionLabel.isHidden = true
		gameViewController.completionLabel.text = ""
		gameViewController.animationImage.image = #imageLiteral(resourceName: "oak_mature")
		gameViewController.animationImage.contentMode = .scaleAspectFit
		gameViewController.fellButton.setTitle("Fell", for: .normal)
		gameViewController.fellButton.setTitle("Fell", for: .focused)
		gameViewController.fellButton.setTitle("Fell", for: .highlighted)
		gameViewController.fellButton.addAction(for: .touchUpInside) {
			self.fellOak()
		}
	}
	
	fileprivate func fellOak() {
		worn_closet.getSignals(by: key_ring.key)?.transmitSignal(by: Consts.oakFelled)
		guard
			let gameViewController = view_controller,
			let oaksFelled = worn_closet.getPresenterEntities(by: key_ring.key)?.getValue(by: oak_count_key) as? Int
			else { return }
		gameViewController.fellButton.isHidden = true
		let gameOver = oaksFelled >= Consts.totalOaksToFell
		if !gameOver {
			gameViewController.animationImage.animationImages = [#imageLiteral(resourceName: "oak_felled"), #imageLiteral(resourceName: "oak_seedling"), #imageLiteral(resourceName: "oak_juvenile"), #imageLiteral(resourceName: "oak_mature")]
			gameViewController.animationImage.animationDuration = Double(gameViewController.animationImage.animationImages!.count * animation_frame_length)
			_ = Timer.scheduledTimer(
				withTimeInterval: TimeInterval(gameViewController.animationImage.animationDuration - 1.0),
				repeats: false) { timer in
					gameViewController.animationImage.stopAnimating()
					gameViewController.animationImage.image = #imageLiteral(resourceName: "oak_mature")
					gameViewController.fellButton.isHidden = false
					timer.invalidate()
			}
			gameViewController.animationImage.startAnimating()
		} else {
			gameViewController.animationImage.stopAnimating()
			gameViewController.animationImage.animationImages = nil
			gameViewController.animationImage.image = #imageLiteral(resourceName: "oak_felled")
			gameViewController.completionLabel.text = "Now the oaks are gone we can build a big industrial plant. Thanks for helping!"
			gameViewController.completionLabel.isHidden = false
		}
	}
}

struct GamePresenter {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset,
	animation_frame_length: Int,
	oak_count_key: String
	
	fileprivate var view_controller: GameViewController? {
		return worn_closet.getPresenterEntities(by: key_ring.key)?.viewController as? GameViewController
	}
	
	init(with keyring: FZKeyring){
		key_ring = keyring
		worn_closet = FZWornCloset(key_ring.key)
		animation_frame_length = 2
		oak_count_key = "Oak"
	}
}
