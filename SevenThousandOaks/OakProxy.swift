//
//  OakProxy.swift
//  SevenThousandOak
//
//  Created by Richard Willis on 22/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import CoreData
import Filzanzug

protocol OakProxyProtocol: FZModelClassProtocol {
	var totalFellings: Int { get }
	func increment ()
}

extension OakProxy: OakProxyProtocol {
	var totalFellings: Int { return total_fellings }
	var wornCloset: FZWornCloset { return worn_closet }

	func increment() {
		set(oaksFelled: total_fellings + 1)
		let attribute = FZCDAttribute(count_attribute_name, total_fellings)
		worn_closet.getModelClassEntities(by: key_ring.key)?.coreData?.update(oak_entity_name, to: attribute) { [weak self] objects in
			guard let safeObjects = objects else { return }
			self?.setOak(by: safeObjects)
		}
	}
	
	func activate () {
		guard let coreData = worn_closet.getModelClassEntities(by: key_ring.key)?.coreData else { return }
		coreData.dataModelName = "MyNiceData"
//		coreData.delete(entityName: oak_entity_name) { _ in } // tmp debug
		coreData.retrieve(oak_entity_name) { [weak self] objects in
			if let safeObjects = objects {
				self?.setOak(by: safeObjects)
			} else {
				self?.storeOak()
			}
		}
	}
	
	func deallocate () {}
	
	fileprivate func set(oaksFelled: Int) {
		guard
			oaksFelled != total_fellings,
			let signals = worn_closet.getSignals(by: key_ring.key)
			else { return }
		total_fellings = oaksFelled
		signals.transmitSignal(by: Consts.oaksFelledSet)
	}
	
	fileprivate func setOak(by objects: [NSManagedObject]) {
		guard
			objects.count == 1,
			let oak = objects[0] as? Oak
			else { return }
		set(oaksFelled: Int(oak.count))
	}
	
	fileprivate func storeOak() {
		guard let coreData = worn_closet.getModelClassEntities(by: key_ring.key)?.coreData else { return }
		let oaksFelled = 0
		var entity = FZCDEntity(oak_entity_name, keys: [FZCDKey(count_attribute_name, FZCDTypes.int)])
		entity.add(FZCDAttribute(count_attribute_name, oaksFelled))
		coreData.store(entity) { [weak self] _ in
			self?.set(oaksFelled: oaksFelled)
		}
	}
}

class OakProxy {
	fileprivate let
	key_ring: FZKeyring,
	worn_closet: FZWornCloset,
	oak_entity_name: String,
	count_attribute_name: String
	
	fileprivate var total_fellings: Int
	
	required init(with keyring: FZKeyring) {
		key_ring = keyring
		worn_closet = FZWornCloset(key_ring.key)
		oak_entity_name = "Oak"
		count_attribute_name = "count"
		total_fellings = -1
	}
}
