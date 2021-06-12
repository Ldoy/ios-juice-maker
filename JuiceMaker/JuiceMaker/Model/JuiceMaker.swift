//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

enum JuiceMenu {
	case strawberryJuice
	case mangoJuice
	case kiwiJuice
	case pineappleJuice
	case bananJuice
	case strawNanaJuice
	case mangoKiwiJuice
	
	func recipe(_ juice: JuiceMenu) -> [(fruit: Fruit, amount: Int)] {
		switch juice {
		case .strawberryJuice:
			return [(Fruit.strawberry, 16)]
		case .bananJuice:
			return [(Fruit.banana, 2)]
		case .kiwiJuice:
			return [(Fruit.kiwi, 3)]
		case .mangoJuice:
			return [(Fruit.mango, 3)]
		case .pineappleJuice:
			return [(Fruit.pineapple, 2)]
		case .strawNanaJuice:
			return [(Fruit.strawberry, 10), (Fruit.banana, 1)]
		case .mangoKiwiJuice:
			return [(Fruit.mango, 2), (Fruit.kiwi, 1)]
		}
	}
}

struct JuiceMaker {
	
	var fruitStores: [FruitStore]
	
	init(fruitStores: [FruitStore]) {
		self.fruitStores = fruitStores
		for kinds in Fruit.allCases {
			self.fruitStores.append(FruitStore(storeName: kinds))
		}
	}

	func findTargetStore(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) -> [FruitStore] {
		let range = 0...fruits.count - 1
		var checkedStores = [FruitStore]()
		for i in range {
			let fruitStore = stores.filter{ $0.name == fruits[i].fruit }
			checkedStores += fruitStore
		}
		return checkedStores
	}
	
	func checkReceipeStoreStock(target store: [FruitStore], receipe fruits: [(fruit: Fruit, amount: Int)]) -> Bool{
		
		let targetStoreNumber = store.count - 1
		let range = 0...targetStoreNumber
		var result: [FruitStore]?
		
		for i in range {
			let possibleStore = store.filter { $0.name == fruits[i].fruit && $0.count >= fruits[i].amount }
			result? += possibleStore
		}
		
		guard result != nil, result?.count != store.count else {
			return false
		}
		return true
	}

	
	func modifyStoreStock(_ possible: Bool) {
		
	}
	
	func checkJuicablity(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) {
		let targetStores = findTargetStore(receipe: fruits, with: stores)
		let checkStock = checkReceipeStoreStock(target: targetStores, receipe: fruits)
		
		

		
	}
}


