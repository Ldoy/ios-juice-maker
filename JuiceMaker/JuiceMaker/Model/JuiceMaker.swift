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
	
	func checkReceipeStoreStock(_ receipes: [(fruit: Fruit, amount: Int)]) throws -> Bool {
		var result: [FruitStore]?
		
		for receipe in receipes {
			let possibleStore = fruitStores.filter { $0.name == receipe.fruit && $0.count >= receipe.amount }
			result? += possibleStore
		}
		
		guard result != nil, result?.count == receipes.count else {
			throw ErrorCase.noStoreOrStock
		}
		
		return true
	}

	func modifyStoreStock(compare menu: JuiceMenu, with fruitStores: [FruitStore]) throws {
		
		let receipeNeeded = menu.recipe(menu)
		
		guard (try? checkReceipeStoreStock(receipeNeeded)) == true else { throw ErrorCase.noStoreOrStock }
		
		let reciepeRange = 0..<fruitStores.count
		
		for i in reciepeRange {
			_ = receipeNeeded.filter{ (reciepe) in if reciepe.fruit == fruitStores[i].name {
				fruitStores[i].modifyCount(-reciepe.amount)
				return true
			}
			return false
		}
	}
	}
}
