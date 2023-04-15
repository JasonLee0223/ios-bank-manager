# iOS-Bank-Manager

🏃🏻🏃🏻‍♂️💨 **프로젝트 기간:** `23.02.20` ~ `23.03.10`   

<a href ="## 🔖 역할 분배">🔖 역할 분배</a>   
<a href ="## Step1 - 큐(Queue)타입 구현">Step1 - 큐(Queue)타입 구현</a>   
<a href ="## Step2 - 타입 구현 및 콘솔앱 구현">Step2 - 타입 구현 및 콘솔앱 구현</a>   
<a href ="Step3 - 다중 처리">Step3 - 다중 처리</a>   

---
## 💻 실행결과
|UI Version|Console Version|
|:---|:---|
|![Simulator Screen Recording - iPhone 12 pro v15 0 - 2023-04-15 at 17 03 06](https://user-images.githubusercontent.com/92699723/232199154-40f519ee-688f-48bd-8ba5-9ad22a87461d.gif)|<img src = "https://user-images.githubusercontent.com/92699723/232199406-a52b5599-072c-4cac-93e5-e634afb0d919.mov">|

## 🔖 역할 분배
### 💻 Console Version
|Manager|역할|
|:---|:---|
|BankManager|startProcess 메서드를 통해 프로그램을 실행시켰을 때 제일 처음 호출된다. <br/>- openBank 메서드를 통해 실제 동작이 이뤄진다.

|Helper|역할|
|:---|:---|
|AsyncProcess|전체적인 동작을 담당하고있으며 비동기적으로 은행 업무를 처리합니다.|
|Teller|은행원 역할로서 CustomerQueue에서 은행 업무를 처리하는 동안의 <br/>업무 소요시간의 TimeInterval이 지연된다.|
|Generator|BankManager의 역할을 분담하기 위해 구현하였다. <br/>- 은행원(Teller)들을 인스턴스화로 만들어주는 메서드와 랜덤으로 고객 수를 만들어내는 메서드를 통해 Manager를 지원한다.|

|Model|역할|
|:---|:---|
|Customer|비즈니스 로직에서 사용하는 근본 데이터 형식|

|Protocol|역할|
|:---|:---|
|Workable|Teller의 identifier를 통해 업무 타입을 확인할 수 있도록 프로토콜로 구현|
|Receivable|BankManager가 업무 시작을 할 수 있도록 사용자 입력을 받을 수 있는 프로토콜 기본구현|

|Enum|역할|
|:---|:---|
|Errors|- 발생할 수 있는 Error 형식을 정의|
|WorkList|사용자 입력을 통해 은행 업무를 진행할 것인지 정할 수 있도록 List 형식으로 구현|
|WorkType|은행 업무 타입을 정의 및 구현|
|CustomCount|고객의 최대, 최소값을 정의|
|OutputMessage|Console에 출력해야 될 메시지를 정의|

|DataStructure|역할|
|:---|:---|
|Node|배열처럼 요소처럼 LinkedList의 요소로 사용되도록 정의|
|LinkedList|Node를 연결된 데이터 구조|
|Queue|LinkedList형태를 인스턴스화하여 사용할 수 있도록 정의|

### 📱 UI Application Version
|ViewController|역할|
|:---|:---|
|ViewController|MainView와 SubView의 라벨이 이동하는 부분을 Delegate를 통해 처리한다.|

|View|역할|
|:---|:---|
|MainView|`고객 10명 추가` 및 `초기화` 버튼을 가지고 있으며 버튼 Action을 담당한다.|   
|SubView|고객 대기열과 업무중의 StackView를 가지고있으며 MainView의 버튼을 통해 업데이트 되는 내용이 보여진다.|   


## Step1 - 큐(Queue)타입 구현
은행에 도착한 고객이 임시로 대기할 큐(Queue) 타입을 직접 구현한다.   
- Queue 타입 구현을 위한 Linked-List 타입을 직접 구현한다.
- 다양한 데이터를 취급할 수 있도록 Generic 기능을 활용한다.
- UnitTest를 통해 동작을 검증한다.
  - Enqueue, Dequeue, Clear, Peek, isEmpty
---

## Step2 - 타입 구현 및 콘솔앱 구현
- 은행에는 n명의 은행원(Teller)이 근무하며 n명의 고객이 업무처리를 위해 대기한다.
  - Step1에서 구현한 Queue 타입을 활용한다.
- 모든 고객의 업무가 끝나면 은행 업무를 마감한다.
- 업무를 마감할 때 아래와 같은 메시지를 출력한다.
  - "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 XX명이며, 총 업무시간은 XX초입니다."
  - 은행원이 업무를 처리하는데 걸리는 시간은 0.7초이다.
    - 한 번에 처리할 수 있는 고객은 한 명이다
  - 업무를 처리하면 아래와 같은 메시지를 출력한다.
    - "3번 고객 업무 시작"
  - 고객의 업무를 처리하면 아래와 같은 메시지를 출력한다.
    - "5번 고객 업무 완료"
---

## Step3 - 다중 처리
- 은행원은 총 3명이 근무한다.
  - 2명은 예금업무, 1명은 대출업무를 처리한다.
- 한 명의 은행원은 한 명의 고객을 응대할 수 있다.
  - 예금 소요시간: 0.7초, 대출 소요시간: 1.1초
- 업무처리 시 아래와 같은 메시지를 출력한다.
  - 업무시작 시: "3번 고객 대출업무 시작"
  - 업무처리 완료 시: "11번 고객 예금업무 완료"

### 🚀 적용하려고 노력해본 점
은행(Bank)라는 객체의 관점으로 추상화해 보았을 떄 2가지 상황이 고려되었다.   
1. 은행이 오픈하지 않았지만 고객이 먼저 와서 기다리는 경우 이미 대기열이 생성되는 경우
2. 은행이 오픈한 뒤 고객이 방문하여 대기열이 생성되는 경우

`DispatchQueue`를 사용하게 된다면 공유자원(고객 대기열 - Queue)에 접근하여 global()로 cucurrenct하게 처리되는   
Thread에 aync로 처리하는 부분은 동일하지만 2번의 경우와 같이 enqueue와 dequeue가   
동시에 일어나는 방법으로 처리하고 싶었다. 아래는 시도해보았던 코드이다.

```Swift
//MARK: - 고객 대기열 생성 - async & enqueue
makeCustomerQueue(of: totalVisitCustomer)

//MARK: - 업무 대기열 생성 - async & dequeue
tellers.forEach { teller in
    workQueue.async(group: workGroup) {
        while !self.customerQueue.isEmpty {
            self.work(start: teller)
        }
    }
}
workGroup.wait()
```
```Swift
//MARK: - 고객 명단 생성
private func makeCustomerQueue(of totalCustomerCount: Int) {
    for waitingNumber in CustomerCount.defaultCustomer...totalCustomerCount {
        let randomAssignToCustomerOfWorkType = makeRandomWorkType()
        let customer = Customer(waitingNumber: waitingNumber, workType: randomAssignToCustomerOfWorkType)
        
        customerQueue.euqueue(customer)
    }
}

private func makeRandomWorkType() -> WorkType {
    let allWorkType = [WorkType.deposit, WorkType.loan].shuffled()
    
    guard let randomAssignToCustomerOfWorkType = allWorkType.first else {
        return .deposit
    }
    return randomAssignToCustomerOfWorkType
}

//MARK: - 은행원이 대기열을 가져간다.
private func work(start teller: Teller) {
    let depositSemaphore = DispatchSemaphore(value: 2)
    let loanSemaphore = DispatchSemaphore(value: 1)
    
    switch teller.identifier {
    case .deposit:
        depositSemaphore.wait()
        guard let finishCustomer = customerQueue.dequeue() else {
            return
        }
        teller.spendTime(of: finishCustomer)
        depositSemaphore.signal()
    case .loan:
        loanSemaphore.wait()
        guard let finishCustomer = customerQueue.dequeue() else {
            return
        }
        teller.spendTime(of: finishCustomer)
        loanSemaphore.signal()
    }
}
```
하지만 위와 같이 enqueue와 dequeue를 동시에 aync(비동기)로 처리하다보니 Queue가 비어질 때까지 반복문을 도는 과정에서   
enqueue를 통해 Queue의 대기열이 생성되는 과정에 `0`으로 처리되는 부분을 확인하였고 dequeue를 처리하는 부분이   
더 빠르게 동작하여 `group.wait()` 메서드를 통과하여 main이 바로 실행되어 버리는 상황을 계속 확인하게 되었다.   
하여 enqueue를 통해 먼저 대기열을 만들어주고 dequeue를 통해 접근하도록 변경하여 처음 2가지 경우의 수에서 1번째 경우로 선택하여 리펙토링하여 진행하였다.

---
