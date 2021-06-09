//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation

class FruitStore {
	enum FruitList: String {
		   case strawberry = "딸기"
		   case banana = "바나나"
		   case kiwi = "키위"
		   case mango = "망고"
		   case pineapple = "파인애플"
	   }
	
	var currentFruit = 10

	func setCount(count: Int) {
		var currentCount: Int {
			get {
				currentFruit += count
				return currentFruit
			}
			set {
				currentFruit = newValue
			}
		}
	}
}
