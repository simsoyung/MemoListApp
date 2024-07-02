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
        label.text = "마감일"
        label.textColor = .darkGray
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        addSubview(addButton)
        addSubview(detailLabel)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    func configureLayout(){
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(20)
            make.height.equalTo(30)
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
