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
	
	
	enum ErrorCase: Error {
		case noStoreOrStock
	}
	
	
	func checkReceipeStoreStock(receipe fruits: [(fruit: Fruit, amount: Int)], target store: [FruitStore]) throws -> Bool {
		var result: [FruitStore]?
		
		for receipe in fruits {
			let possibleStore = store.filter { $0.name == receipe.fruit && $0.count >= receipe.amount }
			result? += possibleStore
		}
		
		guard result != nil, result?.count != store.count else {
			throw ErrorCase.noStoreOrStock
		}
		return true
	}
	
	func modifyStoreStock(receipe fruit: JuiceMenu, with fruitStores: [FruitStore]) throws {
		
		let receipeFruitStore = fruit.recipe(fruit) // 레서피 프룻 스토어
		guard (try? checkReceipeStoreStock(receipe: receipeFruitStore, target: fruitStores)) == true else { throw ErrorCase.noStoreOrStock }
		
		let reciepeRange = 0...receipeFruitStore.count - 1
		for fruit in reciepeRange {
			let _ = receipeFruitStore.filter{ (reciepe) in if reciepe.fruit == fruitStores[fruit].name {
				fruitStores[fruit].modifyCount(-reciepe.amount)
				}
			return true
			}
		}
	}
}


