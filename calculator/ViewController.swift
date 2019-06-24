//
//  ViewController.swift
//  calculator
//
//  Created by Bảo  Hưng on 6/24/19.
//  Copyright © 2019 Bảo  Hưng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    let resultView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let resultLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = UIColor.black
        lbl.text = "0"
        lbl.textColor = .white
        lbl.textAlignment = .right
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont.systemFont(ofSize: 80)
        return lbl
    }()
    

    
    func createNumberButton(num: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle("\(num)", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .lightGray
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self, action: #selector(numberClicked), for: .touchUpInside)
        return btn
    }
    
    let dotButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(".", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .lightGray
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self, action: #selector(dotClicked), for: .touchUpInside)
        return btn
    }()
    
    
    enum Operator: String {
        case clear = "AC"
        case oposite = "+/-"
        case percent = "%"
        case div = "÷"
        case add = "+"
        case mul = "x"
        case minus = "-"
        case equal = "="
    }
    
    func createOperatorButton(op : Operator) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(op.rawValue, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(operatorClicked), for: .touchUpInside)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        switch op {
        case .clear,.oposite,.percent:
            btn.backgroundColor = .darkGray
        default:
            btn.backgroundColor = .orange
        }
        
        return btn
    }
    
    lazy var number0Btn = createNumberButton(num: 0)
    lazy var number1Btn = createNumberButton(num: 1)
    lazy var number2Btn = createNumberButton(num: 2)
    lazy var number3Btn = createNumberButton(num: 3)
    lazy var number4Btn = createNumberButton(num: 4)
    lazy var number5Btn = createNumberButton(num: 5)
    lazy var number6Btn = createNumberButton(num: 6)
    lazy var number7Btn = createNumberButton(num: 7)
    lazy var number8Btn = createNumberButton(num: 8)
    lazy var number9Btn = createNumberButton(num: 9)
    
    lazy var clearBtn = createOperatorButton(op: .clear)
    lazy var opositeBtn = createOperatorButton(op: .oposite)
    lazy var percentBtn = createOperatorButton(op: .percent)
    lazy var divBtn = createOperatorButton(op: .div)
    lazy var mulBtn = createOperatorButton(op: .mul)
    lazy var addBtn = createOperatorButton(op: .add)
    lazy var minusBtn = createOperatorButton(op: .minus)
    lazy var equalBtn = createOperatorButton(op: .equal)

    //
    func setupLayout(){
        view.addSubview(resultView)
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            resultView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/8)
            ])
        
        resultView.addSubview(resultLbl)
        NSLayoutConstraint.activate([
            resultLbl.bottomAnchor.constraint(equalTo: resultView.safeAreaLayoutGuide.bottomAnchor),
            resultLbl.leadingAnchor.constraint(equalTo: resultView.leadingAnchor),
            resultLbl.trailingAnchor.constraint(equalTo: resultView.trailingAnchor),
            resultLbl.heightAnchor.constraint(equalTo: resultView.heightAnchor, multiplier: 2/3)
            ])
        
        let row1 = UIStackView(arrangedSubviews: [clearBtn,opositeBtn,percentBtn,divBtn])
        row1.distribution = .fillEqually
        row1.spacing = 1
        
        let row2 = UIStackView(arrangedSubviews: [number7Btn,number8Btn,number9Btn,mulBtn])
        row2.distribution = .fillEqually
        row2.spacing = 1
        
        let row3 = UIStackView(arrangedSubviews: [number4Btn,number5Btn,number6Btn,minusBtn])
        row3.distribution = .fillEqually
        row3.spacing = 1
        
        let row4 = UIStackView(arrangedSubviews: [number1Btn,number2Btn,number3Btn,addBtn])
        row4.distribution = .fillEqually
        row4.spacing = 1
        
        let row5_right = UIStackView(arrangedSubviews: [dotButton,equalBtn])
        row5_right.distribution = .fillEqually
        row5_right.spacing = 1
        
        let row5 = UIStackView(arrangedSubviews: [number0Btn,row5_right])
        row5.distribution = .fillEqually
        row5.spacing = 1
        
        let stack = UIStackView(arrangedSubviews: [row1,row2,row3,row4,row5])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 1
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: resultView.bottomAnchor)
            ])
        
    }
    
    var isFirstNumber = true
    var firstNumber = ""
    var secondNumber = ""
    
    @objc func operatorClicked(){
        
    }
    @objc func numberClicked(_ sender : UIButton){
        let text = sender.titleLabel!.text
        if isFirstNumber {
            
        }else{
            
        }
    }
    @objc func dotClicked(){
        
    }
    

}

