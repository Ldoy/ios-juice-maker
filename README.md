# 쥬스메이커 - 수정중

### 이 프로젝트는
MVC패턴, KVO, Notification Center, Singleton, 캡슐화/은닉화, 결합력/응집력, 뷰 간의 데이터 이동 등의 학습을 목표하고 있습니다. 

### 이 앱의 내용은
다양한 과일 쥬스를 주문하는 것 입니다. 현재 재고량에 따라 과일 쥬스가 만들어지지 않을 수 있습니다</br>
그러한 경우에는 재고수정 화면으로 진입 해 재고량을 수정하게 됩니다. 혹은 과일 쥬스 버튼을 클릭한 후 재고가 수정되지 않았다는 알람을 통해 재고 수정 화면으로 들어갈 수 있습니다. 


# 프로젝트 중 생긴 문제점

1. 재고 수정 화면과 재고표시 화면의 재고량이 반영되지 않는다
    1. 이유 : 첫 화면은 메모리에 로드되지만 두 번째 화면은 계속 새로운 인스턴스가 생기는 것이기 때문
    2. 해결책 : let juiceMaker = JuiceMaker()를 타입 인스턴스로 바꾼다(수박의 아이디어! 짱!)
 
2. 뷰 컨트롤러 내부에서 어떻게 첫 번째 화면과 두 번째 화면의 코드가 나뉘어 동작하는지 모르겠다
   - 하나의 뷰 컨트롤러가 두개의 뷰를 관리할 때 `viewWillAppear` 안의 코드는 항상 모든 뷰 마다 실행되는데 `guard let` 조건을 통해 첫 번째 화면과 두 번째 화면의 load  가 결정되도록 구현한 것 
   - 이를 알아낸 방법 : breakPoint

     
3. xcode에서는 삭제하였는데 로컬에는 swift 파일이 남아있음
    - 이유 : 삭제 시 `Reference Remove` 눌렀기 때문, 실제 파일은 그대로 남아있음

4. 재고표시화면과 재고수정화면간의 데이터 전달방식을  `static`이 아닌  `Delegate` 방식으로 진행해야 함
    - 이유 : static을 사용하면 타입 프로퍼티이기 때문에 메모리의 최상위에 load되어 있어야함, 인스턴스 프로퍼티의 경우 인스턴스가 만들어고 난 후 해당 인스턴스의 프로퍼티가 메모리에 저장되며 인스턴스가 없어지면 이 프로퍼티도 사라짐. 하지만 타입 프로퍼티는 타입 자체의 프로퍼티이기 때문에 항상 대기타고 있어야함

5. 네비게이션 컨트롤러가 있는 뷰에서 다음 뷰(또다른 네비게이션 컨트롤러가 있는)로 어떻게 화면전환을 하는지? 
    a. 시도 : 처음에는 push-pop 형태로 네비게이션 컨트롤러를 `instance화` 한 후 연결하려 했음 

        ```swift
        func goNextView(){
        		let nextViewControllerId = self.storyboard?.instantiateViewController(withIdentifier: "FruitStore")

        		if let FruitStockVC: UIViewController = nextViewControllerId {
        			FruitStockVC.navigationController?.pushViewController(FruitStockVC, animated: true)
        		}

        //닫기버튼
        @IBAction func exitFuirtStore(_ sender: UIButton) {
        		self.popViewController (이런식으로)
            }
        ```

    b. 결과 : 재고 수정 버튼을 클릭하면 넘어는 가는데 재고 수정 화면에서 닫기를 popViewController 로 구현하려 했지만 안됨 

    c. 해결책 : 위의 함수를 아래와 같이 변경

        ```swift
        func goNextView(){
        		let storeController = self.storyboard?.instantiateViewController(withIdentifier: "FruitStoreNavigationController")
        		
        		if let storeNavigationController = storeController as? UINavigationController {
        			self.present(storeNavigationController, animated: true, completion: nil)
        		}
        	}

        //닫기 버튼
        @IBAction func exitFuirtStore(_ sender: UIButton) {
        		self.dismiss(animated: true, completion: nil)
            }
        ```

    - `pop-push`는 네비게이션 컨트롤러 내부의 뷰 계층 구조 사이의 화면전환 방식. 즉 네비게이션 컨트롤러가 다른  뷰 계층의 경우 `pop-push`로 화면전환이 안됨
    - `present-dismiss` 를 이용해 현재 재고표시 화면에서 다음 재고수정 화면의 네비게이션 컨트롤러로 연결
    - 뷰 를 통한 데이터 적용은 델리게이트 혹은 클로저를 이용하여 사용 가능
    - 현재의 경우에는 `클로저`가 좋음 : 재고수정 화면에서 닫기 버튼 누르기 전에 클로저를 이용해 해당 변경사항을 재고표시 화면에 반영하도록 함 = 비동기적 처리

# 회고
화면 전환 방법과 화면전환 시 어떻게 데이터를 전달하는 가에 대한 학습이 중점적이었다고 할 수 있다. 2주간 중점적으로 찾아본 내용으 세그웨이, 뷰 전환방법, 델리게이트, 뷰 끼리 화면전환방법, 네비게이션 바를 어떻게 코드로 구현할 수 있는지에 대한 내용이었다. 네비게이션 컨트롤러는 연결되어 있느 루트뷰와 그 계층들의 경로를 제공해 주느 컨트롤러 로서 루트 뷰가 다른 네비게이션 컨트롤러를 가지고 있다면 그 네비게이션 컨트롤러를 인스턴스화 하여 present하는 방법이 있음을 알았다. 여기서 헷갈리 수 있는 것이 네비게이션 컨틀로러의 경우 스택 구조로서 push-pop 형태로 뷰 간에 화면전환을 진행하는데 이 개념을 다르 네비게이셔 컨트롤러로 이동하는 경우에는 사용하면 안된다는 것이다. 

또한 화면전환 시 재고량을 반영해 주기 위해서 처음에는 static property를 만들어 타입 자체의 재고량으 두 개의 뷰에 반영하도록 하였다. 하지만 현재는 이 방법이 문제가 되지 않지만 추후 더 많은 뷰가 생겼을 때 재고량이 필요하지 않은 뷰에서도 타입 프로퍼티를 저장하기 위한 메모리공간을 사용하여 효율적이지 못한 메모리 사용을 한다고 볼 수 있다. 이를 refactoring하기 위하여 화면간의 데이터 전달 방식을 찾아보았다. 

1. 데이터 전달 방식
2. 세그웨이
3. Delegate
4. Singleton
5. KVO
6. Notification Center 


## 오늘 내가 고민하고 배운 내용

- 문제가 생기면 원인을 먼저 파악하려고 해야한다. 해결에 먼저 집중하지 말자!!
- 네비게이션 컨트롤러와 뷰 컨트롤러와의 관계 → 네비게이션 컨트롤러가 다른 뷰와 그 subView들은 서로 다른 그룹(?)이다.
- 화면간 데이터 전환은 어떻게 해 줄수 있는가?
- 현업에서는 실제 공부할 시간이 많이 주어지지 않는다. 기능구현을 우선시 해야하는 경우가 생기는데 적어도 개발자라면 그런 요청에 맞추어 적어도 `기능` 을 구현할 수 있어야 한다. (완벽히 그 기능에 대해 모르더라도)

## 문제점

1. 뷰 컨트롤러 내부에서 어떻게 첫 번째 화면과 두 번째 화면의 코드가 나뉘어 동작하는지 모르겠다
    1. 하나의 뷰 컨트롤러가 두개의 뷰를 관리할 때 `viewWillAppear` 안의 코드는 항상 모든 뷰 마다 실행되는데 `guard let` 조건을 통해 첫 번째 화면과 두 번째 화면의 load 가 결정되도록 구현한 것
    2. 이를 알아낸 방법 : 수박의 breakPoint 를 이용한 설명
2. xcode에서는 삭제하였는데 로컬에는 swift 파일이 남아있음
    1. 이유 : 삭제 시 `Reference Remove` 눌렀기 때문, 실제 파일은 그대로 남아있음
3. 재고표시화면과 재고수정화면간의 데이터 전달방식을 `static`이 아닌 `Delegate` 방식으로 진행해야 함
    1. 이유 : static을 사용하면 타입 프로퍼티이기 때문에 메모리의 최상위에 load되어 있어야함, 인스턴스 프로퍼티의 경우 인스턴스가 만들어고 난 후 해당 인스턴스의 프로퍼티가 메모리에 저장되며 인스턴스가 없어지면 이 프로퍼티도 사라짐. 하지만 타입 프로퍼티는 타입 자체의 프로퍼티이기 때문에 항상 대기타고 있어야함
4. 네비게이션 컨트롤러가 있는 뷰에서 다음 뷰(또다른 네비게이션 컨트롤러가 있는)로 어떻게 화면전환을 하는지?
    1. 시도 : 처음에는 push-pop 형태로 네비게이션 컨트롤러를 `instance화` 한 후 연결하려 했음

        ```
        func goNextView(){
        		let nextViewControllerId = self.storyboard?.instantiateViewController(withIdentifier: "FruitStore")

        		if let FruitStockVC: UIViewController = nextViewControllerId {
        			FruitStockVC.navigationController?.pushViewController(FruitStockVC, animated: true)
        		}

        //닫기버튼
        @IBAction func exitFuirtStore(_ sender: UIButton) {
        		self.popViewController (이런식으로)
            }

        ```

    2. 결과 : 재고 수정 버튼을 클릭하면 넘어는 가는데 재고 수정 화면에서 닫기를 popViewController 로 구현하려 했지만 안됨
    3. 해결책 : 위의 함수를 아래와 같이 변경

        ```
        func goNextView(){
        		let storeController = self.storyboard?.instantiateViewController(withIdentifier: "FruitStoreNavigationController")

        		if let storeNavigationController = storeController as? UINavigationController {
        			self.present(storeNavigationController, animated: true, completion: nil)
        		}
        	}

        //닫기 버튼
        @IBAction func exitFuirtStore(_ sender: UIButton) {
        		self.dismiss(animated: true, completion: nil)
            }

        ```

→ 린생의 강의

- `pop-push`는 네비게이션 컨트롤러 내부의 뷰 계층 구조 사이의 화면전환 방식. 즉 네비게이션 컨트롤러가 다른 뷰 계층의 경우 `pop-push`로 화면전환이 안됨
- `present-dismiss` 를 이용해 현재 재고표시 화면에서 다음 재고수정 화면의 네비게이션 컨트롤러로 연결
- 뷰 를 통한 데이터 적용은 델리게이트 혹은 클로저를 이용하여 사용 가능
    - 현재의 경우에는 `클로저`가 좋음 : 재고수정 화면에서 닫기 버튼 누르기 전에 클로저를 이용해 해당 변경사항을 재고표시 화면에 반영하도록 함 = 비동기적 처리
    - 왜좋음...?

1. 데이터 전환 방식

`Delegate, Closure, Action`

[https://www.appcoda.com/data-passing-ios/](https://www.appcoda.com/data-passing-ios/)

1. 타입은 어디에 인스턴스는 메모리영역 어디에 올라가는지?

### 이해안되는 부분

passing data.....

stepper...

### 세 번째 프로젝트 마무리하며

처음에는 뷰 컨트롤러가 뭔지 감이 안잡혔는데 이젠 한 10% 정도는 알듯말듯하다. 2주간의 프로젝트동안 알게 된 것은

`1. 문제가 생겼을 땐 당황하지말고 해결할 수 있다는 자신감을 가지자 2. 문제를 '해결'하기 보단 원인을 '분석' 해야한다. 3. 이 두가지를 할 때 가장 빠르게 문제를 해결할 수 있다.`

는 것이다. 특히 1번이 중요한 것 같다. 자신감이 하락하면 맞는 답안을 찾았을 때도 오답처럼 느껴지기 때문이다. 정말 갖추기 어려운 태도이지만 항상 마음 속에 새기고 나 자신을 격려해 주자.

다음과 같은 개념을 알아야 한다느 것을 알았다. 차차 해당 개념을 정리하고 적용하는 시간을 가져야겠다. 

참고 자료 : 
https://i-colours-u.tistory.com/6


처음에는 뷰 컨트롤러가 뭔지 감이 안잡혔는데 이젠 한 10% 정도는 알듯말듯하다. 2주간의 프로젝트동안 알게 된 것은 
`1. 문제가 생겼을 땐 당황하지말고 해결할 수 있다는 자신감을 가지자 2. 문제를 '해결'하기 보단 원인을 '분석' 해야한다. 3. 이 두가지를 할 때 가장 빠르게 문제를 해결할 수 있다.` 
는 것이다.  특히 1번이 중요한 것 같다. 자신감이 하락하면 맞는 답안을 찾았을 때도 오답처럼 느껴지기 때문이다. 정말 갖추기 어려운 태도이지만 항상 마음 속에 새기고 나 자신을 격려해 주자.
