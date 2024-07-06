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
    var priority: ((String) -> Void)?
    let textView = TextFieldView()
    let dateAddView = ContentsView(frame: .zero, textLabel: "마감일")
    let tagAddView = ContentsView(frame: .zero, textLabel: "태그")
    let priorityAddView = ContentsView(frame: .zero, textLabel: "우선 순위")
    let imageAddView = ContentsView(frame: .zero, textLabel: "이미지 추가")
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "새로운 할 일"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("insertViewController"), object: nil, userInfo: nil)
    }
    override func configureView() {
        super.configureView()
        settingNavigationBarButton()
    }
    override func configureHierarchy() {
        view.addSubview(textView)
        view.addSubview(dateAddView)
        view.addSubview(tagAddView)
        view.addSubview(priorityAddView)
        view.addSubview(imageAddView)
        dateAddView.addButton.addTarget(self, action: #selector(dateAddClicked), for: .touchUpInside)
        tagAddView.addButton.addTarget(self, action: #selector(tagAddClicked), for: .touchUpInside)
        priorityAddView.addButton.addTarget(self, action: #selector(priorityAddClicked), for: .touchUpInside)
    }
    override func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        dateAddView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        tagAddView.snp.makeConstraints { make in
            make.top.equalTo(dateAddView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        priorityAddView.snp.makeConstraints { make in
            make.top.equalTo(tagAddView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        imageAddView.snp.makeConstraints { make in
            make.top.equalTo(priorityAddView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func dateAddClicked() {
        let vc = DatePickerViewController()
        vc.dateResult = { value in
            self.dateAddView.resultLabel.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tagAddClicked() {
        let vc = TagViewController()
        vc.tagResult = { value in
            self.tagAddView.resultLabel.text = value
        }
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
    @objc func priorityAddClicked() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        [ UIAlertAction(title: "최근등록순", style: .default, handler: { action in
            self.priority?(action.title ?? "")
            self.priorityAddView.resultLabel.text = action.title
//            self.priority = { value in
//                self.priorityAddView.resultLabel.text = value
//            }
        }),
          UIAlertAction(title: "날짜순", style: .default, handler: { action in
            self.priority?(action.title ?? "")
            self.priorityAddView.resultLabel.text = action.title
//            self.priority = { value in
//                self.priorityAddView.resultLabel.text = value
//            }
        }),
          UIAlertAction(title: "닫기", style: .destructive)
        ].forEach{ actionSheet.addAction($0) }
        present(actionSheet, animated: true)
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
        let memo = List(memoName: title, memoDetail: content, category: tagAddView.resultLabel.text, creatDate: Date(), deadlineDate: dateAddView.resultLabel.text, checkButton: false, importantButton: false)
        try! realm.write {
            realm.add(memo)
            print("성공")
        }
        NotificationCenter.default.post(name: insertViewController, object: nil, userInfo: nil)
        dismiss(animated: true){
            self.onDismiss?()
        }
    }
    
    @objc func leftButtonTapped(){
        dismiss(animated: true)
    }
}

extension InsertViewController: UISheetPresentationControllerDelegate{
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        sheetPresentationController.largestUndimmedDetentIdentifier = .medium
    }
}
