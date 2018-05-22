//
//  IntroPresenter.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension IntroPresenter: FZPresenterProtocol {
	var wornCloset: FZWornCloset { return worn_closet }
	
	func postViewActivated () {}
	
	func show ( pageName: String ) {}
}

struct IntroPresenter {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset
	fileprivate var view_controller: IntroViewController? {
		return worn_closet.getPresenterEntities(by: key_ring.key)?.viewController as? IntroViewController
	}
	
	init () {
		key_ring = FZKeyring()
		worn_closet = FZWornCloset( key_ring.key )
	}
}
