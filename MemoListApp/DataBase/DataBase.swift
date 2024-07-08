//
//  DataBase.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import RealmSwift

class MemoType: EmbeddedObject {
    @Persisted var content: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
}

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var option: String?
    @Persisted var regDate: Date
    @Persisted var cellColor: String
    @Persisted var detail: List<MemoList>
    @Persisted var memoType: MemoType?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

 class MemoList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var memoName: String //메모이름
    @Persisted var memoDetail: String? //메모내용(옵션)
    @Persisted var category: String? // 카테고리(옵션)
    @Persisted var creatDate: Date // 생성일(필수)
    @Persisted var deadlineDate: String?
    @Persisted var checkButton: Bool = false
    @Persisted var importantButton: Bool = false
    
    @Persisted(originProperty: "detail") var main: LinkingObjects<Folder>
    override static func primaryKey() -> String? {
        return "id"
    }
    
     convenience init(memoName: String, memoDetail: String?, category: String?, creatDate: Date, deadlineDate: String?, checkButton: Bool, importantButton: Bool) {
        self.init()
        self.memoName = memoName
        self.memoDetail = memoDetail
        self.category = category
        self.creatDate = creatDate
        self.deadlineDate = deadlineDate
        self.checkButton = checkButton
    }
    
}
