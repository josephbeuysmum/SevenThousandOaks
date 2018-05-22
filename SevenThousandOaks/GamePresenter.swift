//
//  GamePresenter.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension GamePresenter: FZPresenterProtocol {
	var wornCloset: FZWornCloset { return worn_closet }
	
	func postViewActivated () {}
	
	func show ( pageName: String ) {}
}

struct GamePresenter {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset
	fileprivate var view_controller: GameViewController? {
		return worn_closet.getPresenterEntities(by: key_ring.key)?.viewController as? GameViewController
	}
	
	init () {
		key_ring = FZKeyring()
		worn_closet = FZWornCloset( key_ring.key )
	}
}
