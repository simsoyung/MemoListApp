//
//  Button.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import SnapKit

class ContentsView: UIView {
    
    var addButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        bt.tintColor = .systemGray
        return bt
    }()
    var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .systemGray6
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    init(frame: CGRect, textLabel: String) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
        detailLabel.text = textLabel
    }
    
    func configureHierarchy(){
        addSubview(addButton)
        addSubview(detailLabel)
        addSubview(resultLabel)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    func configureLayout(){
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(20)
            make.height.equalTo(30)
        }
        resultLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(addButton.snp.leading)
            make.height.equalTo(20)
        }
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).inset(20)
            make.size.equalTo(20)
        }
    }
    func configureUI(){
        backgroundColor = .systemGray6
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
