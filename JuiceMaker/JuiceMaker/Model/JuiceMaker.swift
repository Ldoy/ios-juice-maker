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
	} // fruitStores에 name이 Fruit인 애들이 Fruit case 개수만큼 생김
	
	// 1. 사용자가 선택한 쥬스의 레시피 반환
	//2. [(과일종류, 필요개수), (과일종류, 필요개수), ..]를 인자로 받고 해당 과일의 Fruit의 case와 fruitStores의 인스턴스 중 case가 같은 Stores의 count 비교
	// 2.0 과일스토어 찾기
	// 2.1  [(과일종류, 필요개수)]를 인자로 받고 해당 과일의 저장소 개수와 비교하기
	// 2.2 [(과일종류, 필요개수), (과일종류, 필요개수), ..] 여러개가 있을 때 2.1 수행하기
	//3. fruitStores의 해당 FruitStore 인스턴스에 개수가 레시피 개수보다 더 많이 존재하면 해당 count를 감소시키고 쥬스 만들기
	
//	func findFruitStore(_ target: Fruit) -> FruitStore? {
//		var targetStore: FruitStore?
//
//		for store in fruitStores {
//			if store.name == target {
//				targetStore = store
//				break
//			}
//			return targetStore
//		}

		func compare(receipe fruits: [(fruit: Fruit, amount: Int)], with stores: [FruitStore]) -> Bool {

			let range = stores.count - 1
			
			for i in 0...range {
				let fruitStoreName = stores[i].name
				var fruitStoreStock = stores[i].count
				let receipeFruit = fruits[i].fruit
				let receipeFruitAmount = fruits[i].amount
				
				if fruitStoreName == receipeFruit {
					if receipeFruitAmount > fruitStoreStock {
						return false
					}
					fruitStoreStock -= receipeFruitAmount
				}
			}
			return true
		}
		
		
		
		
		
		
		//	func checkJuiceMakable(recipes: [(Fruit, Int)]) -> Bool {
		//		var makable = true
		//
		//		for recipe in recipes {
		//			makable = checkFruitAmount(receipe: recipe)
		//			if !makable {
		//				return false
		//			}
		//		}
		//		return makable
		//	}
		//
		//	func checkFruitAmount(receipe: (name: Fruit, amount: Int)) -> Bool {
		//		guard let store = findFruitStore(name: receipe.name) else {
		//			return false
		//		}
		//		if store.stock >= receipe.amount {
		//			return true
		//		} else {
		//			return false
		//		}
		//	}
		//
		//	func findFruitStore(name: Fruit) -> FruitStore? {
		//		var targetStore: FruitStore?
		//
		//		for store in fruitStores {
		//			if store.name == name.rawValue {
		//				targetStore = store
		//				break
		//			}
		//		}
		//		return targetStore
		//	}
		
	}
