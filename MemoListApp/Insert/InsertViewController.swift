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

    let nameTextField = UITextField()
    let contentTextView = UITextView()
    let imageLineView = UIImageView()

    let realm = try! Realm()
    
    let mainView = ContentsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "새로운 할 일"
    }
    override func configureView() {
        super.configureView()
        settingNavigationBarButton()
        nameTextField.titleTextField()
        contentTextView.overview()
        imageLineView.makeLine()
    }
    override func configureHierarchy() {
        view.addSubview(mainView)
        view.addSubview(nameTextField)
        view.addSubview(contentTextView)
        view.addSubview(imageLineView)
        contentTextView.delegate = self
    }
    override func configureConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        imageLineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(1)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
        mainView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }

        
    }
    func settingNavigationBarButton(){
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    @objc func rightButtonTapped(){
        guard let title = nameTextField.text, !title.isEmpty,
              let content = contentTextView.text else {
            view.makeToast("제목을 입력해주세요.", duration: 3.0, position: .bottom, title: "알림")
            return
        }
        let data = List(memoName: title, memoDetail: content, category: "쇼핑", dataName: Data())
        try! realm.write {
            realm.add(data)
            print("성공")
        }
        dismiss(animated: true)
    }
    @objc func leftButtonTapped(){
        dismiss(animated: true)
    }
}

extension InsertViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모"
            textView.textColor = UIColor.lightGray
        }
    }
}
