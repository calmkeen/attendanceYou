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
    var naviBackButton = UIButton()
    var naviAlertBtn = UIButton()
    var naviListBtn = UIButton()
    
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
        
        naviBackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        naviBackButton.tintColor = .black
        naviBackButton.isHidden = true // 기본적으로 숨김
        
        naviListBtn.setImage(UIImage(systemName: "list.dash"), for: .normal)
        
        naviAlertBtn.setImage(UIImage(systemName: "bell"), for: .normal)
        
        
        addSubview(navigationTitle)
        addSubview(naviBackButton)
        addSubview(naviListBtn)
        addSubview(naviAlertBtn)
        
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
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let topInset = windowScene?.windows.first?.safeAreaInsets.top ?? 0
        navigationTitle.snp.makeConstraints { make in
            make.height.equalTo(100 + topInset) // 노치 사이즈를 위한 조정 필요
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        }
        
        naviBackButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        naviAlertBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        naviListBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
    }
    
    func showBackButton(_ show: Bool) {
        naviBackButton.isHidden = !show
    }
    
    func setBackButtonAction(_ action: @escaping () -> Void) {
        naviBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        // 뒤로가기 액션 처리
        // 실제로는 delegate나 closure로 처리
    }
    
    func bindTabState() {
        let currentTabIndex = TabStateManager.shared.currentTabIndex
        
        // 타이틀 바인딩
        currentTabIndex
            .map { index in
                let titles = TabStateManager.shared.tabTitles
                return index < titles.count ? titles[index] : "홈"
            }
            .bind(to: navigationTitle.rx.text)
            .disposed(by: disposeBag)
        
        // 홈 탭일 때만 alert 버튼 표시
        currentTabIndex
            .map { $0 == 0 }
            .bind(to: naviAlertBtn.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 홈이 아닐 때만 back 버튼 표시
        currentTabIndex
            .map { $0 != 0 }
            .bind(to: naviBackButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
