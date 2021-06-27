//
//  JuiceMaker - FruitStore.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import Foundation
// 싱글턴으로 구현하기.

class FruitStore {
	
	enum FruitKinds: CaseIterable {
		case strawberry
		case banana
		case mango
		case kiwi
		case pineapple
	}
	
	static let shared: FruitStore = FruitStore.init()
	
	private init() {
	}
	
	let name: FruitKinds
	
	init(name: FruitKinds) {
		self.name = name
	}
	
	private var count: Int = 10
	
	var stock: Int {
		return count
	}
	
	func setStockCount(quntity: Int) {
		return count += quntity
	}
}


