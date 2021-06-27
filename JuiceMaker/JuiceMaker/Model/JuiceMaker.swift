//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation
import UIKit

// 역할 : 레시피를 가지고 쥬스만들기
// 무엇을 위임하고 무엇을 전달받을 것인지 : 재고가 남아있는지 확인하는 것 위임하고 그 결과를 전달 받으려고 한다.
// 과일 가게는 싱글턴으로 구현해 보기

// 결국 역할을 두개로 구분하는게 아닐까? JuiceMakerable의 경우 쥬스메이커가 될 수 있는 인스턴스들의 청사진, 즉 쥬스메이커가 되기 위해 가져야 하는 조건들을 명시한 것이고 JuiceMakerDelegate의 경우에는 JuiceMaker가 해야하는 일이라고 할 수 있지만 역할의 decouple 을 위해 즉 역할을 구분짓기 위해 JuiceMaker의 역할을 delegate에게 주고 해당 역할의 결과를 나에게 가져오라고 하는 것.

protocol JuiceMakerable {
	func makeJuice() -> Bool
	var delegate: JuiceMakerDelegate { get set }
	// 다른 역할을 가진 프로토콜이 다른 프로토콜 안에서 인스턴스가 생기도록 함. 그래서 delegate 프로토콜의 경우 나중에 내부 구현을 하는 이유.
}
//
//extension JuiceMakerable {
//	func makeJuice() -> Bool {
//		if delegate.checkFruitStoreStock() {
//			return true
//		}
//		return false
//	}
//} // 델리게이트의 역할을 사용하기 위해 선언했던 'delegate'에게 과일가게 있는지 찾아오라고 시킴 -> 그 결과에 따라 나도 만들 수 있는지 없는지 확인하겠다!


protocol JuiceMakerDelegate {
	func checkFruitStoreStock() -> Bool
}

struct JuiceMaker : JuiceMakerable {
	var delegate: JuiceMakerDelegate
	var bananaStore = FruitStore(name: .banana)
	
	func makeJuice() -> Bool {
		if delegate.checkFruitStoreStock() {
			return true
		}
		return false
	}
}

class JuiceMakerController : UIViewController, JuiceMakerDelegate {
	
	var juiceMaker: JuiceMaker?
	
	func checkFruitStoreStock() -> Bool {
		if let bananaStock = juiceMaker?.bananaStore.stock, bananaStock > 10 {
			return true
		}
		return false
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		juiceMaker?.delegate = self // 쥬스메이커타입의 델리게이트가 뷰 컨트롤러가 됨.(채택했기 때문에 가능)
		if juiceMaker?.makeJuice() != nil {
			// 쥬스만들기가 가능한 경우 어떤 것을 보일지
		}
		
	}
	
	

}
	
	
//	import Foundation
//
//	protocol 뷰가가능한 {
//		var delegate: ViewDelegate? { get set }
//		func touchAction()
//		func touchBackground()
//	}
//
//	// 역할 -> 전달
//	extension 뷰가가능한 {
//		func touchAction() {
//			delegate?.touchAction()
//		}
//
//		func touchBackground() {
//
//		}
//	}
//
//	protocol ViewDelegate {
//		func touchAction()
//	}
//
//	// 기준 -> 역할 자신
//	// MVC 패턴 정의 -> view 역할, Controller 역할, Model 역할
//
//	// 역할 -> 이벤트 전달
//	class View: 뷰가가능한 {
//
//		var background: String = "white"
//
//		var delegate: ViewDelegate?
//	}
//
//	class View2: 뷰가가능한 {
//		var delegate: ViewDelegate?
//	}
//
//	// 역할 -> 비지니스 로직 검사, 모델 생성, 모델 update, view update
//	class Controller {
//		var view: View = View()
//
//		func viewdidLoad() {
//
//		}
//
//	}
//
//	class Manager: ViewDelegate {
//		func touchAction() {
//			print()
//		}
//
//		var view: 뷰가가능한?
//
//		func main() {
//			view?.touchAction()
//			view?.delegate = self
//		}
//	}
//
//	// model -> 데이터 저장 -> 데이터 생성
//
//
	
}
