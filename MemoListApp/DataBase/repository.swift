//
//  repository.swift
//  MemoListApp
//
//  Created by 심소영 on 7/8/24.
//

import Foundation
import RealmSwift

final class Repository {
    
    private let realm = try! Realm()
    
    func addMemoInFolder(_ folder: Folder){
        let memo = MemoType()
        memo.content = "잘들어갔네요"
        memo.editDate = Date()
        memo.regDate = Date()
        do {
            try realm.write{
                folder.memoType = memo
            }
        } catch {
            
        }
    }
    
    func fetchFolder() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func removeFolder(_ folder: Folder){
        do {
            try realm.write {
                realm.delete(folder.detail)
                realm.delete(folder)
                print("성공")
            }
        } catch {
            print("삭제 에러")
        }
    }
     
    func detectRealmURL(){
        print(realm.configuration.fileURL ?? "")
    }
    
    func createFolder(_ data: Folder, folder: Folder){
        do {
             try realm.write {
                 folder.realm?.add(data)
                print("성공")
            }
        } catch {
            print("에러났지롱")
        }

    }
    
    func createItem(_ data: MemoList, folder: Folder){
        do {
             try realm.write {
                 folder.detail.append(data)
                print("성공")
            }
        } catch {
            print("에러났지롱")
        }

    }
    
    func fetchItem() -> [MemoList] {
       let value = realm.objects(MemoList.self)
        return Array(value)
    }
    
    func removeItem(_ data: MemoList){
        try! realm.write{
            realm.delete(data)
        }
    }
}
