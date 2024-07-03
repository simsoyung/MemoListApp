//
//  DataBase.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import RealmSwift

final class List: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var memoName: String //메모이름
    @Persisted var memoDetail: String? //메모내용(옵션)
    @Persisted var category: String? // 카테고리(옵션)
    @Persisted var creatDate: Date // 생성일(필수)
    @Persisted var deadlineDate: String?
    @Persisted var checkButton: Bool = false
    
    convenience init(memoName: String, memoDetail: String?, category: String?, creatDate: Date, deadlineDate: String?, checkButton: Bool) {
        self.init()
        self.memoName = memoName
        self.memoDetail = memoDetail
        self.category = category
        self.creatDate = creatDate
        self.deadlineDate = deadlineDate
        self.checkButton = checkButton
    }
    
}
