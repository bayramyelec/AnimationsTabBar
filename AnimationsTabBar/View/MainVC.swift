//
//  MainVC.swift
//  AnimationsTabBar
//
//  Created by Bayram Yeleç on 14.02.2025.
//

import UIKit

class MainVC: UIViewController, CustomTabbarDelegate {
    
    private let vc1 = UINavigationController(rootViewController: VC1())
    private let vc2 = UINavigationController(rootViewController: VC2())
    private let vc3 = UINavigationController(rootViewController: VC3())
    private let vc4 = UINavigationController(rootViewController: VC4())
    
    private let tabbarController = CustomTabbar()
    
    private var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        view.backgroundColor = .white
        view.addSubview(tabbarController)
        tabbarController.delegate = self
        tabbarController.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        showVC(vc: vc1)
    }
    
    func didSelectTab(at index: Int) {
        switch index {
        case 1:
            showVC(vc: vc1)
        case 2:
            showVC(vc: vc2)
        case 3:
            showVC(vc: vc3)
        case 4:
            showVC(vc: vc4)
        default:
            break
        }
    }
    
    private func showVC(vc: UIViewController){
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        addChild(vc)
        view.insertSubview(vc.view, belowSubview: tabbarController)
        vc.view.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(tabbarController.snp.top)
        }
        vc.didMove(toParent: self)
        currentVC = vc
    }
    
}
