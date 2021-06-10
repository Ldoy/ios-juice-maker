//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation


enum Fruit: String, CaseIterable {
	case strawberry = "딸기"
	case banana = "바나나"
	case kiwi = "키위"
	case mango = "망고"
	case pineapple = "파인애플"
}




struct JuiceMaker {
	
	var fruitStorage =  [FruitStore]() // [딸기(), 바나나(),...]
    
    init(){
        for fruit in Fruit.allCases {
            fruitStorage.append(FruitStore(storeName: fruit.rawValue))
        }
    }
    
	enum JuiceMenu {
		case strawberryJuice
		case bananaJuice
		case kiwiJuice
		case mangoJuice
		case pineappleJuice
		case strawNanaJuice
		case mangoKiwiJuice
		
		var recipe:[(Fruit ,Int)] {
			switch self {
			case .strawberryJuice:
				return [(.strawberry, 16)]
			case .bananaJuice:
				return [(.banana, 2)]
			case .kiwiJuice:
				return [(.kiwi, 3)]
			case .mangoJuice:
				return [(.mango, 3)]
			case .pineappleJuice:
				return [(.pineapple, 2)]
			case .strawNanaJuice:
				return [(.strawberry, 10), (.banana, 1)]
			case .mangoKiwiJuice:
				return [(.mango, 2), (.kiwi, 1)]
			}
		}
	
	
		
    func checkJuiceMakable(targetStore: FruitStore, amount: Int) -> Bool {
        if targetStore.stock >= amount {
            return true
        } else {
            return false
        }
    }
    
    func makeJuice(wanted: JuiceMenu){
        let recipes = wanted.recipe // (.banana, 16)
        var makable = true
		for (fruit, need) in recipes {
			if fruit == fruitStorage.first{ where fruit in } {
				
			}
		}
		
    }
		
}
}

