# iOS-Bank-Manager

🏃🏻🏃🏻‍♂️💨 **프로젝트 기간:** `23.02.20` ~ `23.03.10`

## 🔖 역할 분배
### 💻 Console Version
|Manager|역할|
|:---|:---|
|BankManager|- startProcess 메서드를 통해 프로그램을 실행시켰을 때 제일 처음 호출된다. <br/>- openBank 메서드를 통해 실제 동작이 이뤄진다.

|Helper|역할|
|:---|:---|
|AsyncProcess|- 전체적인 동작을 담당하고있으며 비동기적으로 은행 업무를 처리합니다.|
|Teller|- 은행원 역할로서 CustomerQueue에서 은행 업무를 처리하는 동안의 <br/>업무 소요시간의 TimeInterval이 지연된다.|
|Generator|- BankManager의 역할을 분담하기 위해 구현하였다. <br/>- 은행원(Teller)들을 인스턴스화로 만들어주는 메서드와 랜덤으로 고객 수를 만들어내는 메서드를 통해 Manager를 지원한다.|

|Model|역할|
|:---|:---|
|Customer|- 비즈니스 로직에서 사용하는 근본 데이터 형식|

|Protocol|역할|
|:---|:---|
|Workable|- Teller의 identifier를 통해 업무 타입을 확인할 수 있도록 프로토콜로 구현|
|Receivable|- BankManager가 업무 시작을 할 수 있도록 사용자 입력을 받을 수 있는 프로토콜 기본구현|

|Enum|역할|
|:---|:---|
|Errors|- 발생할 수 있는 Error 형식을 정의|
|WorkList|- 사용자 입력을 통해 은행 업무를 진행할 것인지 정할 수 있도록 List 형식으로 구현|
|WorkType|- 은행 업무 타입을 정의 및 구현|
|CustomCount|- 고객의 최대, 최소값을 정의|
|OutputMessage|- Console에 출력해야 될 메시지를 정의|

|DataStructure|역할|
|:---|:---|
|Node|- 배열처럼 요소처럼 LinkedList의 요소로 사용되도록 정의|
|LinkedList|- Node를 연결된 데이터 구조|
|Queue|- LinkedList형태를 인스턴스화하여 사용할 수 있도록 정의|


### 📱 UI Application Version