//
//  MemoListViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import RealmSwift
import SnapKit

class MemoListViewController: BaseViewController {
    let insertViewController: Notification.Name = Notification.Name("insertViewController")
    lazy var menuItems: [UIAction] = {
        return [
            UIAction(title: "날짜순", handler: { _ in
                self.deadlineDateReload()
            }),
            UIAction(title: "최근등록순", handler: { _ in
                self.makeDateReload()
            }),
        ]
    }()
    lazy var menu: UIMenu = {
        return UIMenu(title: "", options: [], children: menuItems)
    }()
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        return label
    }()
    var list: Results<List>!
    let realm = try! Realm()
    var tableview = UITableView()
    var changeRadio: (() -> Bool)?
    
    override func viewDidAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBarButton()
        //list = realm.objects(List.self)
        print("테이블뷰에 뜨는 리스트",list, list.count)
        NotificationCenter.default.addObserver(self, selector: #selector(insertViewController(_:)), name: NSNotification.Name("insertViewController"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: insertViewController, object: nil, userInfo: nil)
    }
    @objc func insertViewController(_ noti: Notification) {
        OperationQueue.main.addOperation {
            self.tableview.reloadData()
        }
    }
    func deadlineDateReload(){
        list = realm.objects(List.self).sorted(byKeyPath: "deadlineDate", ascending: true)
        tableview.reloadData()
    }
    func makeDateReload(){
        list = realm.objects(List.self).sorted(byKeyPath: "creatDate", ascending: false)
        tableview.reloadData()
    }
    
    func settingNavigationBarButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
            menu: menu)
    }    

    override func configureView() {
        super.configureView()
        tableview.rowHeight = 80
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.id)
    }
    override func configureHierarchy() {
        view.addSubview(tableview)
        view.addSubview(headerLabel)
    }
    override func configureConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        tableview.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list[indexPath.row]
        let saveAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            print("좋아요!")
            }
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            try! self.realm.write{
                self.realm.delete(data)
                tableView.reloadData()
            }
        }
        saveAction.image = UIImage(systemName: "hand.thumbsup")
        saveAction.backgroundColor = .systemTeal
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [saveAction, deleteAction ])
        return configuration
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.id) as! MemoTableViewCell
        let data = list[indexPath.row]
        cell.titleNameLabel.text = data.memoName
        cell.detailContentLabel.text = data.memoDetail
        cell.categoryLabel.text = data.category
        cell.dateLabel.text = data.deadlineDate
        if data.checkButton == false {
            cell.radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            cell.radioButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        }
        cell.radioButton.tag = indexPath.row
        cell.radioButton.addTarget(self, action: #selector(toggleRadio(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func toggleRadio(_ sender: UIButton){
        let index = sender.tag
        let item = list[index]
        sender.isSelected.toggle()
        if sender.isSelected {
            try! self.realm.write{
                item.checkButton.toggle()
            }
            tableview.reloadData()
        }
    }
}
