//
//  MemoTableViewCell.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import SnapKit

final class MemoTableViewCell: BaseTableViewCell {
    
    var radioButton = RadioButton()
    var titleNameLabel =  UILabel()
    var detailContentLabel = UILabel()
    var categoryLabel = UILabel()
    var dateLabel = UILabel()

    override func configureView() {
        titleNameLabel.cellLabel(size: 15, fontWeight: .heavy, color: .black)
        detailContentLabel.cellLabel(size: 13, fontWeight: .medium, color: .darkGray)
        categoryLabel.cellLabel(size: 13, fontWeight: .medium, color: .systemBlue)
        dateLabel.cellLabel(size: 13, fontWeight: .medium, color: .darkGray)
    }
    override func configureLayout() {
        radioButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(15)
        }
        titleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(radioButton.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
        detailContentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(radioButton.snp.trailing).offset(10)
            make.height.equalTo(14)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(detailContentLabel.snp.bottom).offset(5)
            make.leading.equalTo(radioButton.snp.trailing).offset(10)
            make.height.equalTo(14)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(detailContentLabel.snp.bottom).offset(5)
            make.leading.equalTo(dateLabel.snp.trailing).offset(5)
            make.height.equalTo(14)
        }
    }
    override func configureHierarchy() {
        contentView.addSubview(radioButton)
        contentView.addSubview(titleNameLabel)
        contentView.addSubview(detailContentLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(dateLabel)
    }
}
