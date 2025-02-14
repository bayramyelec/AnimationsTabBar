//
//  CustomTabbar.swift
//  AnimationsTabBar
//
//  Created by Bayram Yeleç on 14.02.2025.
//

import UIKit

class CustomTabbar: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var tab1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var tab2: UIButton = { createButton(image: "heart", tag: 2) }()
    private lazy var tab3: UIButton = { createButton(image: "magnifyingglass", tag: 3) }()
    private lazy var tab4: UIButton = { createButton(image: "bell", tag: 4) }()
    
    private lazy var selectedTabView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var selectedTabView2: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedTabIndex: Int = 1
    private var selectedTabViewXConstraint: NSLayoutConstraint!
    private var selectedTabViewWidthConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 80)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tabWidth = backView.frame.width / 4
        selectedTabViewWidthConstraint.constant = tabWidth
    }
    
    private func setupUI() {
        addSubview(backView)
        addSubview(stackView)
        backView.addSubview(selectedTabView)
        selectedTabView.addSubview(selectedTabView2)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backView.rightAnchor.constraint(equalTo: self.rightAnchor),

            stackView.topAnchor.constraint(equalTo: backView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: backView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: backView.rightAnchor),
        ])
        
        [tab1, tab2, tab3, tab4].forEach {
            stackView.addArrangedSubview($0)
        }
        
        selectedTabViewXConstraint = selectedTabView.centerXAnchor.constraint(equalTo: tab1.centerXAnchor)
        selectedTabViewWidthConstraint = selectedTabView.widthAnchor.constraint(equalToConstant: self.frame.width / 4)
        
        NSLayoutConstraint.activate([
            selectedTabView.heightAnchor.constraint(equalToConstant: 70),
            selectedTabViewWidthConstraint,
            selectedTabView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectedTabViewXConstraint,
            
            selectedTabView2.centerXAnchor.constraint(equalTo: selectedTabView.centerXAnchor),
            selectedTabView2.centerYAnchor.constraint(equalTo: selectedTabView.centerYAnchor),
            selectedTabView2.widthAnchor.constraint(equalToConstant: 50),
            selectedTabView2.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
    
    private func createButton(image: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = .gray
        button.tag = tag
        button.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        return button
    }
    
    @objc private func createButtonAction(_ sender: UIButton) {
        updateSelection(sender)
        moveSelectedView(sender)
        selectedTabIndex = sender.tag
    }
    
    private func updateSelection(_ selectedButton: UIButton) {
        [tab1, tab2, tab3, tab4].forEach {
            $0.tintColor = $0 == selectedButton ? .white : .gray
        }
    }
    
    private func moveSelectedView(_ selectedButton: UIButton) {
        selectedTabViewXConstraint.isActive = false
        selectedTabViewXConstraint = selectedTabView.centerXAnchor.constraint(equalTo: selectedButton.centerXAnchor)
        
        NSLayoutConstraint.activate([
            selectedTabViewXConstraint
        ])
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
