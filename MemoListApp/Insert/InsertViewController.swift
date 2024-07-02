//
//  InsertViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import RealmSwift
import Toast
import SnapKit

final class InsertViewController: BaseViewController {
    
    let insertViewController: Notification.Name = Notification.Name("insertViewController")
    let realm = try! Realm()
    let textView = TextFieldView()
    let mainView = ContentsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "새로운 할 일"
    }
    override func configureView() {
        super.configureView()
        settingNavigationBarButton()
    }
    override func configureHierarchy() {
        view.addSubview(textView)
        view.addSubview(mainView)
    }
    override func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }

        mainView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }

        
    }
    func settingNavigationBarButton(){
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    @objc func rightButtonTapped(){
        guard let title = textView.nameTextField.text, !title.isEmpty,
              let content = textView.contentTextView.text else {
            view.makeToast("제목을 입력해주세요.", duration: 3.0, position: .bottom, title: "알림")
            return
        }
        let data = List(memoName: title, memoDetail: content, category: "#쇼핑", dataName: Data())
        try! realm.write {
            realm.add(data)
            print("성공")
        }
        NotificationCenter.default.post(name: insertViewController, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
    @objc func leftButtonTapped(){
        dismiss(animated: true)
    }
}


