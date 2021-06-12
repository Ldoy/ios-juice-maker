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
	
	func compare(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) -> Bool {
		
		let range = 0...stores.count - 1
		let range2 = 0...fruits.count - 1
		var result = false
		
		for i in range {
			let fruitStoreName = stores[i].name
			let fruitStoreStock = stores[i].count
			
			for a in range2 {
				
				let receipeFruit = fruits[a].fruit
				let receipeFruitAmount = fruits[a].amount
				
				if fruitStoreName == receipeFruit {
					let checkAmount = checkAmount(receipe: receipeFruitAmount, store: fruitStoreStock)
					result = checkAmount
				}
				
				if !result {
					break
				}
			}
		}
		return result
	}
	
	func checkAmount(receipe amount: Int, store stock: Int) -> Bool {
		if amount > stock{
			return false
		}
		return true
	}
	
	
	func checkStore(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) -> [FruitStore]{
		let number = 0...fruits.count - 1
		var b = [FruitStore]()
		for i in number {
			let a = stores.filter{ $0.name == fruits[i].fruit }
			b += a
		}
		return b
	}
	
	
	
}


