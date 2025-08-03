//
//  BaseViewController.swift
//  attandanceApp
//
//  Created by calmkeen on 7/13/25.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    var BaseView = UIView()
    var topnavigationView = NavigationBar()
    var bottomTabView = BottomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        view.addSubview(BaseView)
        view.addSubview(topnavigationView)
        view.addSubview(bottomTabView)
    }

    func setupLayout() {
        BaseView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        topnavigationView.snp.makeConstraints{ make in
            make.top.equalTo(BaseView.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.1)
        }
        bottomTabView.snp.makeConstraints{ make in
            make.bottom.equalTo(BaseView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.1)
        }
    }
}
