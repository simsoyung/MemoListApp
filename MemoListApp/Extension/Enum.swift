//
//  Enum.swift
//  MemoListApp
//
//  Created by 심소영 on 7/9/24.
//

import UIKit
enum TypeButton: String, CaseIterable {
    case today = "오늘"
    case will = "예정"
    case all = "전체"
    case important = "깃발 표시"
    case complete = "완료"
    
    var typeColor: String {
        switch self {
        case .today:
            "249AF0"
        case .will:
            "F55238"
        case .all:
            "8E9091"
        case .important:
            "F4E140"
        case .complete:
            "81DB6D"
        }
    }
    var typeIamge: String {
        switch self {
        case .today:
            "text.badge.checkmark"
        case .will:
            "calendar"
        case .all:
            "tray.fill"
        case .important:
            "flag.fill"
        case .complete:
            "checkmark"
        }
    }
}


