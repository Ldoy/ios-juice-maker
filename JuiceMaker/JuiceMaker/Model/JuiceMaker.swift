//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation




struct JuiceMaker {

	enum JuiceMenu: String {
		case strawberryJuice
		case kiwiJuice
		case bananaJuice
		case pineappleJuice
		case strawNanaJuice
		case mangoJucie
		case mangoKiwiJucie
	}
	
	var strawberry = FruitStore()
	var banana = FruitStore()
	var kiwi = FruitStore()
	var mango = FruitStore()
	var pineapple = FruitStore()
	
	func makeJuice(menu: JuiceMenu) {
		switch menu {
		case .strawberryJuice:
			if strawberry.currentFruit > 16 {
			strawberry.setCount(count: -16)
			} else {
				break
			}
		case .bananaJuice:
			if banana.currentFruit > 2 {
				banana.setCount(count: -2)
			} else {
				break
			}
		case .kiwiJuice:
			if kiwi.currentFruit > 3 {
				kiwi.setCount(count: -3)
			} else {
				break
			}
		default:
			print("wrong menu")
		}
	}
}

