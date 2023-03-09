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
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - UI Component
    var stachView: UIStackView = {
        let stackView = UIStackView()
        
        
        return stackView
    }()
    
    var addTenCustomer: UIButton = {
        let addTenCustomer = UIButton()
        
        return addTenCustomer
    }()
    
    var reset: UIButton = {
        let reset = UIButton()
        
        return reset
    }()
    
    var officeHours: UILabel = {
        let officeHours = UILabel()
        
        
        return officeHours
    }()
    
    var waiting: UILabel = {
        let waiting = UILabel()
        
        return waiting
    }()
    
    var working: UILabel = {
        let working = UILabel()
        
        return working
    }()
}
