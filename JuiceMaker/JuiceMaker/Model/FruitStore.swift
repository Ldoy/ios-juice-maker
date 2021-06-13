//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation

// 과일 타입
enum Fruit: CaseIterable {
	case strawberry
	case banana
	case kiwi
	case mango
	case pineapple
}


class FruitStore {
	var name: Fruit
	var count: Int = 10
	
	init(storeName: Fruit) {
		self.name = storeName
	}
	
	func modifyCount(_ number: Int) throws {
	
		
		guard count >= 0 else {
			throw ErrorCase.storeStockShortage
		}
		
		
		var modifiedCount: Int {
			get {
				count += number
				return count
			}
			set {
				count += number
			}
		}
		
	}
}
