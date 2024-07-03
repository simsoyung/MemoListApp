//
//  MainViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/3/24.
//

import UIKit
import SnapKit
import RealmSwift

final class MainViewController: BaseViewController {

    let todayCell = MainTypeView(frame: .zero, imageView: "text.badge.checkmark", typeName: "오늘", cololr: UIColor.systemBlue)
    let scheduleCell = MainTypeView(frame: .zero, imageView: "calendar", typeName: "예정", cololr: UIColor.systemRed)
    let allCell = MainTypeView(frame: .zero, imageView: "tray.fill", typeName: "전체", cololr: UIColor.systemGray)
    let importantCell = MainTypeView(frame: .zero, imageView: "flag.fill", typeName: "깃발 표시", cololr: UIColor.systemYellow)
    let finishCell = MainTypeView(frame: .zero, imageView: "checkmark", typeName: "완료됨", cololr: UIColor.systemGreen)
    
    var list: Results<List>!
    let realm = try! Realm()
    let buttonConfig = UIButton.Configuration.plain()
    lazy var insertButton = UIButton(configuration: buttonConfig)
    lazy var listTableButton = UIButton(configuration: buttonConfig)
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func configureView() {
        super.configureView()
        insertButton.contentMode = .center
        insertButton.settingButton(text: "새로운 할 일", imageName: "plus.circle.fill")
        listTableButton.settingButton(text: "목록 추가", imageName: "list.clipboard.fill")
        insertButton.addTarget(self, action: #selector(insertClicked), for: .touchUpInside)
        listTableButton.addTarget(self, action: #selector(listTableClicked), for: .touchUpInside)
        let results = realm.objects(List.self)
        todayCell.numLabel.text = "0"
        scheduleCell.numLabel.text = "0"
        allCell.numLabel.text = "\(results.count)"
        importantCell.numLabel.text = "0"
        finishCell.numLabel.text = "0"
        
    }
    override func configureHierarchy() {
        view.addSubview(headerLabel)
        view.addSubview(todayCell)
        view.addSubview(scheduleCell)
        view.addSubview(allCell)
        view.addSubview(importantCell)
        view.addSubview(finishCell)
        view.addSubview(insertButton)
        view.addSubview(listTableButton)
    }
    override func configureConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        todayCell.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(180)
        }
        allCell.snp.makeConstraints { make in
            make.top.equalTo(todayCell.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(180)
        }
        finishCell.snp.makeConstraints { make in
            make.top.equalTo(allCell.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(180)
        }
        scheduleCell.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(180)
        }
        importantCell.snp.makeConstraints { make in
            make.top.equalTo(scheduleCell.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(180)
        }
        insertButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        listTableButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func insertClicked(){
        let insertView = InsertViewController()
        let nav = UINavigationController(rootViewController: insertView)
        nav.modalPresentationStyle = .pageSheet
        self.present(nav, animated: true )
    }
    @objc func listTableClicked(){
        let newViewController = MemoListViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
