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

    var selectedList = [
    ["text.badge.checkmark","calendar","tray.fill","flag.fill","checkmark" ],
    ["오늘","예정","전체","깃발 표시","완료됨"],
    ]
    var colorList: [UIColor] =     [UIColor.systemBlue,UIColor.systemRed,UIColor.systemGray,UIColor.systemYellow,UIColor.systemGreen]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = realm.objects(List.self)
        NotificationCenter.default.addObserver(self, selector: #selector(insertViewController(_:)), name: NSNotification.Name("insertViewController"), object: nil)
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
        let results = realm.objects(List.self)
        cell.collectionCell.numLabel.text = "\(results.count)"
        cell.collectionCell.listimageView.image = UIImage(systemName: selectedList[0][indexPath.row])
        cell.collectionCell.typeLabel.text = selectedList[1][indexPath.row]
        cell.collectionCell.listimageView.backgroundColor = colorList[indexPath.row]
        return cell
    }
    
    
}
