//
//  AppDelegate.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(schemaVersion: 3) {
            //마이그레이션이 꼭 왜 필요할까?
            //왜 if else로 쓰지 않을까?
            migration, oldSchemaVersion in
            //변경된 테이블에 대해서 알려주기
            if oldSchemaVersion < 1 {
                //폴더 컬럼 추가
                //단순 컬럼, 테이블 추가나 삭제등의 경우에는 코드 x
            }
            if oldSchemaVersion < 2 {
                //컬럼명을 변경했을경우, 안에 들어있던 데이터를 옮겨줘야함
                //migration.renameProperty(onType: MemoList.className(), from: "favorite", to: "isLike")
            }
            if oldSchemaVersion < 3 {

            }
        }
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

