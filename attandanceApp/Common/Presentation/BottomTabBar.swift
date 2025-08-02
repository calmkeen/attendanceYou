//
//  BottomTabBar.swift
//  attandanceApp
//
//  Created by calmkeen on 7/13/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BottomTabBar: UIView {
    private let disposeBag = DisposeBag()
    
    var bottomStackView = UIStackView()
    
    // 탭 아이템들을 배열로 관리
    var tabItems: [UIStackView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstraint()
        setupTabGestures()
        bindTabState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setConstraint()
        setupTabGestures()
        bindTabState()
    }
    
    // 탭 아이템 생성 함수
    static func createTabItem(icon: String, title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: icon)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        // 이미지뷰 크기 설정
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        return stackView
    }
    
    func setup() {
        // 메인 스택뷰 설정
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.alignment = .center
        bottomStackView.spacing = 0
        bottomStackView.backgroundColor = .white
        
        addSubview(bottomStackView)
        
        // TabStateManager에서 탭 정보를 가져와서 동적으로 생성
        createTabItems()
    }
    
    func createTabItems() {
        let tabManager = TabStateManager.shared
        
        // 기존 탭 아이템들 제거
        tabItems.forEach { $0.removeFromSuperview() }
        tabItems.removeAll()
        
        // TabStateManager의 정보로 탭 아이템들 생성
        for (index, icon) in tabManager.tabIcons.enumerated() {
            let title = tabManager.tabTitles[index]
            let tabItem = Self.createTabItem(icon: icon, title: title)
            tabItems.append(tabItem)
            bottomStackView.addArrangedSubview(tabItem)
        }
    }
    
    func setConstraint() {
        bottomStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTabGestures() {
        for (index, tabItem) in tabItems.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
            tabItem.addGestureRecognizer(tapGesture)
            tabItem.tag = index
        }
    }
    
    @objc func tabTapped(_ gesture: UITapGestureRecognizer) {
        guard let tabItem = gesture.view else { return }
        let index = tabItem.tag
        TabStateManager.shared.selectTab(index)
    }
    
    func bindTabState() {
        TabStateManager.shared.currentTabIndex
            .subscribe(onNext: { [weak self] selectedIndex in
                self?.updateTabSelection(selectedIndex)
            })
            .disposed(by: disposeBag)
    }
    
    func updateTabSelection(_ selectedIndex: Int) {
        for (index, tabItem) in tabItems.enumerated() {
            let isSelected = index == selectedIndex
            
            // 선택된 탭 스타일 변경
            tabItem.alpha = isSelected ? 1.0 : 0.6
            
            // 아이콘 색상 변경
            if let imageView = tabItem.arrangedSubviews.first as? UIImageView {
                imageView.tintColor = isSelected ? .systemBlue : .black
            }
            
            // 텍스트 색상 변경
            if let label = tabItem.arrangedSubviews.last as? UILabel {
                label.textColor = isSelected ? .systemBlue : .black
            }
        }
    }
}
