//
//  DatePickerViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/3/24.
//

import UIKit
import RealmSwift
import Toast
import SnapKit

final class DatePickerViewController: BaseViewController {
    
    var selectedLabel = UILabel()
    let datePicker = UIDatePicker()
    var dateResult: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dateResult?(self.selectedLabel.text ?? "")
    }
    
    override func configureView() {
        super.configureView()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(dateChange(_:)), for: .valueChanged)
    }
    override func configureHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(selectedLabel)
        selectedLabel.textAlignment = .center
        selectedLabel.textColor = .darkGray
        selectedLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        selectedLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(44)
        }
    }
    @objc func dateChange(_ sender: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yy.MM.dd"
        let date = dateformatter.string(from: sender.date)
        selectedLabel.text = date
    }
    
}
