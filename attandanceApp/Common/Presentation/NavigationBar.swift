//
//  NavigationBar.swift
//  attandanceApp
//
//  Created by calmkeen on 7/13/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NavigationBar: UINavigationBar {
    private let disposeBag = DisposeBag()
    
    var navigationTitle = UILabel()
    var navigationButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        barTintColor = .white
        isTranslucent = false
        
        navigationTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationTitle.textColor = .black
        navigationTitle.textAlignment = .center
        
        navigationButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        navigationButton.tintColor = .black
        navigationButton.isHidden = true // 기본적으로 숨김
        
        addSubview(navigationTitle)
        addSubview(navigationButton)
        
        setupConstraints()
        bindTabState()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let topInset = windowScene?.windows.first?.safeAreaInsets.top ?? 0
        
        snp.updateConstraints { make in
            make.height.equalTo(44 + topInset)
        }
    }
    
    func setupConstraints() {
        navigationTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.6)
        }
        
        navigationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        snp.makeConstraints { make in
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let topInset = windowScene?.windows.first?.safeAreaInsets.top ?? 0
            make.height.equalTo(44 + topInset)
        }
    }
    
    func showBackButton(_ show: Bool) {
        navigationButton.isHidden = !show
    }
    
    func setBackButtonAction(_ action: @escaping () -> Void) {
        navigationButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        // 뒤로가기 액션 처리
        // 실제로는 delegate나 closure로 처리
    }
    
    func bindTabState() {
        TabStateManager.shared.currentTabIndex
            .subscribe(onNext: { [weak self] index in
                let titles = TabStateManager.shared.tabTitles
                self?.navigationTitle.text = index < titles.count ? titles[index] : "홈"
            })
            .disposed(by: disposeBag)
    }
}
