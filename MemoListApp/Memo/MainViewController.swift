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
    let insertViewController: Notification.Name = Notification.Name("insertViewController")
    var selectedList = [
    ["text.badge.checkmark","calendar","tray.fill","flag.fill","checkmark" ],
    ["오늘","예정","전체","깃발 표시","완료됨"],
    ["", "", "", "", ""]
    ]
    var colorList: [UIColor] = [UIColor.systemBlue,UIColor.systemRed,UIColor.systemGray,UIColor.systemYellow,UIColor.systemGreen]
    var list: Results<List>!
    let realm = try! Realm()
    let buttonConfig = UIButton.Configuration.plain()
    lazy var insertButton = UIButton(configuration: buttonConfig)
    lazy var calendarButton = UIButton(configuration: buttonConfig)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(insertViewController(_:)), name: NSNotification.Name("insertViewController"), object: nil)
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        let dateString = formatter.string(from: Date())
        let filteredItem0 = realm.objects(List.self).filter("deadlineDate == '\(dateString)'")
        selectedList[2][0] = String(filteredItem0.count)
        let filteredItem1 = realm.objects(List.self)
        selectedList[2][1] = String(filteredItem1.count)

        let filteredItem2 = realm.objects(List.self)
        selectedList[2][2] = String(filteredItem2.count)
        
        let filteredItem3 = realm.objects(List.self)
        selectedList[2][3] = String(filteredItem3.count)
        
        let filteredItem4 = realm.objects(List.self).filter("checkButton == true")
        selectedList[2][4] = String(filteredItem4.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        list = realm.objects(List.self)
    }
    override func configureView() {
        super.configureView()
        insertButton.contentMode = .center
        insertButton.settingButton(text: "새로운 할 일", imageName: "plus.circle.fill")
        calendarButton.settingButton(text: "캘린더", imageName: "list.clipboard.fill")
        insertButton.addTarget(self, action: #selector(insertClicked), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarClicked), for: .touchUpInside)
        
    }
    override func configureHierarchy() {
        view.addSubview(headerLabel)
        view.addSubview(collectionView)
        view.addSubview(insertButton)
        view.addSubview(calendarButton)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemoCollectionViewCell.self, forCellWithReuseIdentifier: MemoCollectionViewCell.id)
    }
    override func configureConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
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
    @objc func insertViewController(_ noti: Notification) {
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    @objc func insertClicked(){
        let insertView = InsertViewController()
        let nav = UINavigationController(rootViewController: insertView)
        nav.modalPresentationStyle = .pageSheet
        self.present(nav, animated: true )
    }
    @objc func calendarClicked(){
        let newViewController = MemoListViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedList[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCollectionViewCell.id, for: indexPath) as! MemoCollectionViewCell
        cell.collectionCell.listimageView.image = UIImage(systemName: selectedList[0][indexPath.row])
        cell.collectionCell.typeLabel.text = selectedList[1][indexPath.row]
        cell.collectionCell.listimageView.backgroundColor = colorList[indexPath.row]
        cell.collectionCell.numLabel.text = "\(selectedList[2][indexPath.row])"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCollectionViewCell.id, for: indexPath) as! MemoCollectionViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        let dateString = formatter.string(from: Date())
        if indexPath.row == 0 {
            let filteredItems = realm.objects(List.self).filter("deadlineDate == '\(dateString)'")
            let newViewController = MemoListViewController()
            newViewController.list = filteredItems
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else if indexPath.row == 1 {
            print(1)
            let filteredItems = realm.objects(List.self).filter("deadlineDate == '\(dateString)'")
            print("필터된 리스트",filteredItems)
            let newViewController = MemoListViewController()
            newViewController.list = filteredItems
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else if indexPath.row == 2 {
            print(2)
            let filteredItems = realm.objects(List.self)
            let newViewController = MemoListViewController()
            newViewController.list = filteredItems
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else if indexPath.row == 3 {
            print(3)
            let filteredItems = realm.objects(List.self).filter("checkButton == true")
            print("필터된 리스트",filteredItems)
            cell.collectionCell.numLabel.text = "\(filteredItems.count)"
            let newViewController = MemoListViewController()
            newViewController.list = filteredItems
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            let filteredItems = realm.objects(List.self).filter("checkButton == true")
            let newViewController = MemoListViewController()
            cell.collectionCell.numLabel.text = "\(filteredItems.count)"
            newViewController.list = filteredItems
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
}
