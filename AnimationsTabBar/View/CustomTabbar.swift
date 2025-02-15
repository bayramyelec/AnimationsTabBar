//
//  CustomTabbar.swift
//  AnimationsTabBar
//
//  Created by Bayram Yeleç on 14.02.2025.
//

protocol CustomTabbarDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

import UIKit
import SnapKit

class CustomTabbar: UIView {
    
    weak var delegate: CustomTabbarDelegate?
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
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
        button.tag = 1
        button.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var tab2: UIButton = { createButton(image: "heart", tag: 2) }()
    private lazy var tab3: UIButton = { createButton(image: "magnifyingglass", tag: 3) }()
    private lazy var tab4: UIButton = { createButton(image: "bell", tag: 4) }()
    
    private lazy var selectedTabView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var selectedTabView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedTabIndex: Int = 1
    
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
    
    private func setupUI() {
        addSubview(backView)
        addSubview(stackView)
        backView.addSubview(selectedTabView)
        selectedTabView.addSubview(selectedTabView2)
        [tab1, tab2, tab3, tab4].forEach {
            stackView.addArrangedSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        selectedTabView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(backView.snp.width).multipliedBy(0.25)
            make.bottom.equalTo(stackView.snp.bottom).inset(10)
            make.centerX.equalTo(tab1.snp.centerX)
        }
        selectedTabView2.snp.makeConstraints { make in
            make.center.equalTo(selectedTabView.snp.center)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        tab1.transform = CGAffineTransform(translationX: 0, y: -10)
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
        delegate?.didSelectTab(at: selectedTabIndex)
    }
    
    private func updateSelection(_ selectedButton: UIButton) {
        [tab1, tab2, tab3, tab4].forEach {
            $0.tintColor = $0 == selectedButton ? .white : .gray
        }
    }
    
    private func moveSelectedView(_ selectedButton: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.selectedTabView.snp.remakeConstraints { make in
                make.height.equalTo(80)
                make.width.equalTo(self.backView.snp.width).multipliedBy(0.25)
                make.bottom.equalTo(self.stackView.snp.bottom).inset(10)
                make.centerX.equalTo(selectedButton.snp.centerX)
            }
            [self.tab1, self.tab2, self.tab3, self.tab4].forEach { button in
                button.transform = .identity
            }
            selectedButton.transform = CGAffineTransform(translationX: 0, y: -10)
            self.layoutIfNeeded()
        }
    }
}
