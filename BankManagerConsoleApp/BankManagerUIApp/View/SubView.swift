//
//  SubView.swift
//  BankManagerUIApp
//
//  Created by Jason on 2023/03/10.
//

import UIKit

class SubView: UIView {
    
    //MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        addLabels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
        addLabels()
    }
    
    //MARK: - View Component
    var subStackView: UIStackView = {
        let subStackView = UIStackView()
        subStackView.axis = .horizontal
        subStackView.distribution = .fillEqually
        
        return subStackView
    }()
    
    var waitingScrollView: UIScrollView = {
        let waitingScrollView = UIScrollView()
        waitingScrollView.backgroundColor = .systemBlue
        
        return waitingScrollView
    }()
    
    var workingScrollView: UIScrollView = {
        let workingScrollView = UIScrollView()
        workingScrollView.backgroundColor = .systemOrange
        
        return workingScrollView
    }()
    
    var waitingStackView: UIStackView = {
        let waitingStackView = UIStackView()
        waitingStackView.axis = .vertical
        
        return waitingStackView
    }()
    
    var workingStackView: UIStackView = {
        let workingStackView = UIStackView()
        workingStackView.axis = .vertical
        
        return workingStackView
    }()
    
    //MARK: - UI Component
    private func addLabels() {
        (0..<5).map { index in
            let label: UILabel = {
                let label = UILabel()
                label.text = "Test Text" + String(index)
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 15, weight: .regular)
                
                return label
            }()
            return label
        }
        .forEach(waitingStackView.addArrangedSubview)
    }
    
    //MARK: - Layout
    private func configureLayout() {
        self.addSubview(subStackView)
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subStackView.topAnchor.constraint(equalTo: topAnchor),
            subStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            subStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        [waitingScrollView, workingScrollView].forEach {
            self.subStackView.addArrangedSubview($0)
        }
        
        waitingScrollView.addSubview(waitingStackView)
        workingScrollView.addSubview(workingStackView)
        
        waitingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            waitingStackView.topAnchor.constraint(equalTo: waitingScrollView.topAnchor),
            waitingStackView.leadingAnchor.constraint(equalTo: waitingScrollView.leadingAnchor),
            waitingStackView.trailingAnchor.constraint(equalTo: waitingScrollView.trailingAnchor),
            waitingStackView.bottomAnchor.constraint(equalTo: waitingScrollView.bottomAnchor),
            waitingStackView.widthAnchor.constraint(equalTo: waitingScrollView.widthAnchor),
        ])
        
        workingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workingStackView.topAnchor.constraint(equalTo: workingScrollView.topAnchor),
            workingStackView.leadingAnchor.constraint(equalTo: workingScrollView.leadingAnchor),
            workingStackView.trailingAnchor.constraint(equalTo: workingScrollView.trailingAnchor),
            workingStackView.bottomAnchor.constraint(equalTo: workingScrollView.bottomAnchor),
            workingStackView.widthAnchor.constraint(equalTo: workingScrollView.widthAnchor)
        ])
    }
}
