//
//  MemoListViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import RealmSwift

final class MemoListViewController: BaseViewController {
    
    var list: Results<List>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBarButton()
    }
    
    func settingNavigationBarButton(){
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    func leftButtonTapped(){
        let insertView = InsertViewController()
        let nav = UINavigationController(rootViewController: insertView)
        nav.modalPresentationStyle = .pageSheet
        self.present(nav, animated: true)
    }

    override func configureView() {
        super.configureView()
    }
    override func configureHierarchy() {
        
    }
    override func configureConstraints() {
        
    }
}
