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
			return [(Fruit.kiwi, 2)]
		case .mangoJuice:
			return [(Fruit.mango, 3)]
		case .pineappleJuice:
			return [(Fruit.pineapple, 4)]
		case .strawNanaJuice:
			return [(Fruit.strawberry, 2), (Fruit.banana, 3)]
		case .mangoKiwiJuice:
			return [(Fruit.kiwi, 2), (Fruit.banana, 3)]
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


	func checkStore(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) -> [FruitStore] {
		let range = 0...fruits.count - 1
		var checkedStores = [FruitStore]()
		for i in range {
			let fruitStore = stores.filter{ $0.name == fruits[i].fruit }
			checkedStores += fruitStore
		}
		return checkedStores
	}
	
	func compare(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) -> Bool {
		let targetStores = checkStore(receipe: fruits, with: stores)
		let range = 0...targetStores.count - 1
		var result: Int = 0
		
		for i in range {
			let possibleStore = fruits.filter{ $0.fruit == targetStores[i].name && $0.amount >= targetStores.count }.count
			result += possibleStore
		}
		
		if result != targetStores.count {
			return false
		}
		
		return true
	}
}


