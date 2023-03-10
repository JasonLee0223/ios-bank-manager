//
//  MainView.swift
//  BankManagerUIApp
//
//  Created by Jason on 2023/03/10.
//

import UIKit

class MainView: UIView {
    
    //MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configurLayout()
    }
    
    //MARK: - UI Component
    var mainStachView: UIStackView = {
        let mainStachView = UIStackView()
        mainStachView.axis = .vertical
        mainStachView.distribution = .fillEqually
        
        return mainStachView
    }()
    
    var userInterfaceStackView: UIStackView = {
        let userInterfaceStackView = UIStackView()
        userInterfaceStackView.axis = .horizontal
        userInterfaceStackView.distribution = .fillEqually

        return userInterfaceStackView
    }()
    
    var timerStackView: UIStackView = {
        let timerStackView = UIStackView()
        timerStackView.axis = .horizontal
        timerStackView.distribution = .fill
        
        return timerStackView
    }()
    
    var statusStackView: UIStackView = {
        let statusStackView = UIStackView()
        statusStackView.axis = .horizontal
        statusStackView.distribution = .fillEqually

        return statusStackView
    }()

    var addTenCustomer: UIButton = {
        let addTenCustomer = UIButton()
        addTenCustomer.setTitle("고객 10명 추가", for: .normal)
        addTenCustomer.setTitleColor(.systemBlue, for: .normal)

        return addTenCustomer
    }()

    var reset: UIButton = {
        let reset = UIButton()
        reset.setTitle("초기화", for: .normal)
        reset.setTitleColor(.systemRed, for: .normal)

        return reset
    }()

    var officeHours: UILabel = {
        let officeHours = UILabel()
        officeHours.text = "업무시간"
        officeHours.font = .systemFont(ofSize: 20, weight: .regular)
        officeHours.textAlignment = .center

        return officeHours
    }()

    var waiting: UILabel = {
        let waiting = UILabel()
        waiting.backgroundColor = .systemGreen
        waiting.text = "대기중"
        waiting.textColor = .white
        waiting.textAlignment = .center
        waiting.font = .systemFont(ofSize: 30, weight: .bold)

        return waiting
    }()

    var working: UILabel = {
        let working = UILabel()
        working.backgroundColor = .systemPurple
        working.text = "업무중"
        working.textColor = .white
        working.textAlignment = .center
        working.font = .systemFont(ofSize: 30, weight: .bold)

        return working
    }()
    
    //MARK: - Layout
    private func configurLayout() {
        self.addSubview(mainStachView)
        mainStachView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStachView.topAnchor.constraint(equalTo: topAnchor),
            mainStachView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStachView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStachView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        [userInterfaceStackView, timerStackView, statusStackView].forEach{
            self.mainStachView.addArrangedSubview($0)
        }

        self.userInterfaceStackView.addArrangedSubview(addTenCustomer)
        self.userInterfaceStackView.addArrangedSubview(reset)
        
        self.timerStackView.addArrangedSubview(officeHours)

        self.statusStackView.addArrangedSubview(waiting)
        self.statusStackView.addArrangedSubview(working)
    }
}
