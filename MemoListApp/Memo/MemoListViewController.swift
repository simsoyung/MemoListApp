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
    let repository = Repository()
    let realm = try! Realm()
    var tableview = UITableView()
    var changeRadio: (() -> Bool)?
    var folder: Folder?
    var list: [MemoList] = []
    var item: Results<MemoList>!
    let buttonConfig = UIButton.Configuration.plain()
    lazy var insertButton = UIButton(configuration: buttonConfig)
    lazy var calendarButton = UIButton(configuration: buttonConfig)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(insertViewController(_:)), name: NSNotification.Name("insertViewController"), object: nil)
        if let folder = folder {
            let value = folder.detail
            list = Array(value)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBarButton()
    }
    
    @objc func insertViewController(_ noti: Notification) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    func deadlineDateReload(){
        item = realm.objects(MemoList.self).sorted(byKeyPath: "deadlineDate", ascending: true)
        tableview.reloadData()
    }
    func makeDateReload(){
        item = realm.objects(MemoList.self).sorted(byKeyPath: "creatDate", ascending: false)
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
        insertButton.contentMode = .center
        insertButton.settingButton(text: "새로운 할 일", imageName: "plus.circle.fill")
        calendarButton.settingButton(text: "캘린더", imageName: "list.clipboard.fill")
        insertButton.addTarget(self, action: #selector(insertClicked), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarClicked), for: .touchUpInside)
    }
    override func configureHierarchy() {
        view.addSubview(tableview)
        view.addSubview(headerLabel)
        view.addSubview(insertButton)
        view.addSubview(calendarButton)
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
        insertButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        calendarButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    @objc func insertClicked(){
        let insertView = InsertViewController()
        let nav = UINavigationController(rootViewController: insertView)
        nav.modalPresentationStyle = .pageSheet
        insertView.folder = folder
        self.present(nav, animated: true )
    }
    @objc func calendarClicked(){
        let newViewController = MemoListViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list[indexPath.row]
        let saveAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            try! self.realm.write{
                self.list[indexPath.row].importantButton.toggle()
                tableView.reloadData()
                }
            }
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [self] (action, view, completionHandler) in
            repository.removeItem(self.list[indexPath.row])
            list = repository.fetchItem()
            tableview.reloadData()
        }
        let image = data.importantButton ? "flag.fill" : "flag"
        saveAction.image = UIImage(systemName: image )
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
        cell.categoryLabel.text = data.main.first?.name
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
