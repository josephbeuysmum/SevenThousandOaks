//
//  FZRoutingExtension.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

extension FZRoutingService: FZRoutingServiceExtensionProtocol {
	public func registerDependencies (with key: String) {
		register(FZCoreDataProxy.self, with: key)
		register(OakProxy.self, with: key, injecting: [FZCoreDataProxy.self])
		register(
			viewControllerId: Consts.introViewController,
			viewControllerType: IntroViewController.self,
			interactorType: IntroInteractor.self,
			presenterType: IntroPresenter.self,
			with: key,
			injecting: [OakProxy.self])
		register(
			viewControllerId: Consts.gameViewController,
			viewControllerType: GameViewController.self,
			interactorType: GameInteractor.self,
			presenterType: GamePresenter.self,
			with: key,
			injecting: [FZCoreDataProxy.self, OakProxy.self])
	}
}
