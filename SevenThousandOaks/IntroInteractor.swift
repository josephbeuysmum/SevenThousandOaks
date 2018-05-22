//
//  IntroInteractor.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension IntroInteractor: FZInteractorProtocol {
	var wornCloset: FZWornCloset { return worn_closet }
	func postPresenterActivated () {}
}

struct IntroInteractor {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset
	fileprivate var presenter_: IntroPresenter? {
		return worn_closet.getInteractorEntities(by: key_ring.key)?.presenter as? IntroPresenter
	}
	
	init () {
		key_ring = FZKeyring()
		worn_closet = FZWornCloset(key_ring.key)
	}
}
