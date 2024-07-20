//
//  MainViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/3/24.
//

import UIKit
import SnapKit
import RealmSwift
import FSCalendar



final class MainViewController: BaseViewController {
    let insertViewController: Notification.Name = Notification.Name("insertViewController")
    var list: [MemoList] = []
    var folderList: [Folder] = []
    let repository = Repository()
    var buttonColor: UIColor?
    var folder: Folder?
    let realm = try! Realm()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var dataSource: UICollectionViewDiffableDataSource<Folder, MemoList>!
    
    static func layout() -> UICollectionViewLayout {
        var layout = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layout.showsSeparators = false
        layout.backgroundColor = .gray
        let view = UICollectionViewCompositionalLayout.list(using: layout)
        return view
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
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(realm.configuration.fileURL)
        folderList = repository.fetchFolder()
        if let folder = folder {
            let value = folder.detail
            list = Array(value)
            print("dddddd",folder)
        }
        configurationCell()
        updateCell()
    }
    override func configureView() {
        super.configureView()
    }
    override func configureHierarchy() {
        view.addSubview(headerLabel)
        view.addSubview(collectionView)
        //collectionView.delegate = self
        //collectionView.dataSource = self
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
    }
    func updateCell(){
        var snapshot = NSDiffableDataSourceSnapshot<Folder, MemoList>()
        snapshot.appendSections(folderList)
        snapshot.appendItems(list, toSection: folderList.first)
        dataSource.apply(snapshot)
    }
    private func configurationCell(){
        var registertation: UICollectionView.CellRegistration<UICollectionViewListCell, MemoList>!
        registertation = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.memoName
            content.secondaryText = itemIdentifier.memoDetail
            content.image = UIImage(systemName: "star")
            cell.contentConfiguration = content
            var back = UIBackgroundConfiguration.listGroupedCell()
            back.backgroundColor = .lightGray
            back.cornerRadius = 10
            cell.backgroundConfiguration = back
        })
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registertation, for: indexPath, item: itemIdentifier)
            return cell
        })
    }

}
//extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        folderList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCollectionViewCell.id, for: indexPath) as! MemoCollectionViewCell
//        cell.collectionCell.listimageView.image = UIImage(systemName: folderList[indexPath.row].option ?? "star")
//        cell.collectionCell.typeLabel.text = folderList[indexPath.row].name
//        cell.collectionCell.listimageView.backgroundColor = UIColor(hexCode: "\(folderList[indexPath.row].cellColor)")
//        cell.collectionCell.numLabel.text = "\(folderList[indexPath.row].detail.count)"
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCollectionViewCell.id, for: indexPath) as! MemoCollectionViewCell
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyMMdd"
//        let dateString = formatter.string(from: Date())
//        guard Int("\(dateString)") != nil else { return }
//        if indexPath.row == 0 {
//            let filteredItems = realm.objects(MemoList.self).filter("deadlineDate == '\(dateString)'")
//            let newViewController = MemoListViewController()
//            let folderitem = folderList[indexPath.row]
//            newViewController.folder = folderitem
//            newViewController.list = Array(filteredItems)
//            self.navigationController?.pushViewController(newViewController, animated: true)
//        } else if indexPath.row == 1 {
//            let filteredItems = realm.objects(MemoList.self)
//                .filter { item in
//                if let itemDate = formatter.date(from: item.deadlineDate ?? ""),
//                   let todayDate = formatter.date(from: dateString) {
//                    return itemDate > todayDate
//                }
//                return false
//            }
//            
//            let newViewController = MemoListViewController()
//            let folderitem = folderList[indexPath.row]
//            newViewController.folder = folderitem
//            newViewController.list = Array(filteredItems)
//            cell.collectionCell.numLabel.text = "\(filteredItems.count)"
//            self.navigationController?.pushViewController(newViewController, animated: true)
//        } else if indexPath.row == 2 {
//            let filteredItems = realm.objects(MemoList.self)
//            let newViewController = MemoListViewController()
//            let folderitem = folderList[indexPath.row]
//            newViewController.folder = folderitem
//            newViewController.list = Array(filteredItems)
//            cell.collectionCell.numLabel.text = "\(filteredItems.count)"
//            self.navigationController?.pushViewController(newViewController, animated: true)
//        } else if indexPath.row == 3 {
//            let filteredItems = realm.objects(MemoList.self).filter("importantButton == true")
//            cell.collectionCell.numLabel.text = "\(filteredItems.count)"
//            let newViewController = MemoListViewController()
//            let folderitem = folderList[indexPath.row]
//            newViewController.folder = folderitem
//            newViewController.list = Array(filteredItems)
//            self.navigationController?.pushViewController(newViewController, animated: true)
//        } else {
//            let filteredItems = realm.objects(MemoList.self).filter("checkButton == true")
//            let newViewController = MemoListViewController()
//            let folderitem = folderList[indexPath.row]
//            newViewController.folder = folderitem
//            cell.collectionCell.numLabel.text = "\(filteredItems.count)"
//            newViewController.list = Array(filteredItems)
//            self.navigationController?.pushViewController(newViewController, animated: true)
//        }
//    }
//}
