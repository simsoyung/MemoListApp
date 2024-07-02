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
    

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print(#function)
        tableview.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBarButton()
        list = realm.objects(List.self)
        NotificationCenter.default.addObserver(self, selector: #selector(insertViewController(_:)), name: NSNotification.Name("insertViewController"), object: nil)
    }
    
    func settingNavigationBarButton(){
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func insertViewController(_ noti: Notification) {
        OperationQueue.main.addOperation {
            self.tableview.reloadData()
        }
    }
    
    @objc func leftButtonTapped(){
        let insertView = InsertViewController()
        let nav = UINavigationController(rootViewController: insertView)
        nav.modalPresentationStyle = .pageSheet
        self.present(nav, animated: true, completion: { self.tableview.reloadData()} )
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
        return cell
    }
}
