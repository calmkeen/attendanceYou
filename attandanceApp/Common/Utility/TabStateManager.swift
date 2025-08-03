//
//  TabStateManager.swift
//  attandanceApp
//
//  Created by calmkeen on 8/2/25.
//

import Foundation
import RxSwift
import RxCocoa

class TabStateManager {
    static let shared = TabStateManager()
    
    private init() {}
    
    let currentTabIndex = BehaviorRelay<Int>(value: 0)
    
    let tabTitles = ["홈", "스케줄", "출석", "결제", "프로필"]
    let tabIcons = ["house", "calendar", "checkmark.circle", "creditcard", "person"]
    
    func selectTab(_ index: Int) {
        guard index >= 0 && index < tabTitles.count else { return }
        currentTabIndex.accept(index)
    }
}
