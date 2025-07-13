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
    var topnavigationView = UIView()
    var bottomTabView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        
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
