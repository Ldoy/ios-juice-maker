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
	
	//레시피의 필요 과일종류와 개수가 해당 과일의 저장고에 있는지 확인하기 들어가는 과일 개수가 몇 개 인지 모르기 때문에 한개씩 비교하는 함수 구현 후 여러개의 경우 해당 함수 여러번 돌리도록 해야함
	func test() {
	
	}

}
