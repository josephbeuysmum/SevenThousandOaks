//
//  IntroPresenter.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension IntroPresenter: PresenterProtocol {
	var wornCloset: FZWornCloset { return worn_closet }
	
	func populateView(with oaksFelled: Int) {
		guard let introViewController = view_controller else { return }
		let copy: String
		switch true {
		case oaksFelled < 1:
			copy = "7000 Oaks is a tremedously boring game in which you chop down 7000 oak trees in succession. Every oak takes five seconds to grow to maturity, after which it can be felled.\n\nTotal 'game' time is about ten hours."
		case oaksFelled < Consts.totalOaksToFell:
			let oakText = oaksFelled == 1 ? "oak" : "oaks"
			copy = "Well done, you have already felled \(oaksFelled) \(oakText), it won't be long until you've truly undermined the biodiversity in this region, and made room for increased industrial production.\n\nI know it can be a bit dull, but these trees really do need clearing. Please continue the good work!"
		default:
			introViewController.playButton.isHidden = true
			copy = "You have felled all \(oaksFelled) oaks, fabulous work!\n\nThe dirty, great industrial plant we are going to put in their place is going to generate a tremendous amount of employment and 'trickle down' revenue.\n\nThe 1% thanks you!"
		}
		introViewController.copyLabel.text = copy
	}
	
	func postViewActivated () {
		guard let introViewController = view_controller else { return }
		introViewController.copyLabel.makeWrappable()
		introViewController.backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
		introViewController.backgroundImage.clipsToBounds = true
		introViewController.backgroundImage.image = #imageLiteral(resourceName: "oak_mature")
		introViewController.headerLabel.text = "7000 Oaks"
		introViewController.copyLabel.text = ""
		introViewController.playButton.setTitle("Play", for: .normal)
		introViewController.playButton.addAction(for: .touchUpInside) {
			self.present(Consts.gameViewController)
		}
	}
}

struct IntroPresenter {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset
	fileprivate var view_controller: IntroViewController? {
		return worn_closet.getPresenterEntities(by: key_ring.key)?.viewController as? IntroViewController
	}
	
	init(with keyring: FZKeyring){
		key_ring = keyring
		worn_closet = FZWornCloset(key_ring.key)
	}
}
