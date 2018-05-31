//
//  GameInteractor.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension GameInteractor: FZInteractorProtocol {
	var wornCloset: FZWornCloset { return worn_closet }
	func postPresenterActivated () {
		guard
			let signals = worn_closet.getSignals(by: key_ring.key),
			let oaksFelledProxy = self.worn_closet.getInteractorEntities(by: self.key_ring.key)?.bespokeRail.getModelClass(by: OakProxy.self) as? OakProxy,
			let gamePresenter = self.presenter_
			else { return }
		gamePresenter.populateView(with: oaksFelledProxy.totalFellings)
		signals.scanFor(key: Consts.oakFelled, scanner: self) { _,_ in
			oaksFelledProxy.increment()
		}
		signals.scanFor(key: Consts.oaksFelledSet, scanner: self) { key, data in
			gamePresenter.populateView(with: oaksFelledProxy.totalFellings)
		}
	}
}

struct GameInteractor {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset
	
	fileprivate var presenter_: GamePresenter? {
		get { return worn_closet.getInteractorEntities(by: key_ring.key)?.presenter as? GamePresenter }
		set {}
	}
	
	init(with keyring: FZKeyring){
		key_ring = keyring
		worn_closet = FZWornCloset(key_ring.key)
	}
}
