//
//  MainTypeView.swift
//  MemoListApp
//
//  Created by 심소영 on 7/3/24.
//

import UIKit
import SnapKit

class MainTypeView: UIView {
    
    lazy var listimageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.contentMode = .center
        image.clipsToBounds = true
        image.tintColor = .white
        return image
    }()
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()

    }
    
    func configureHierarchy(){
        addSubview(listimageView)
        addSubview(typeLabel)
        addSubview(numLabel)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    func configureLayout(){
        listimageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(10)
            make.size.equalTo(40)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(listimageView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(20)
            make.height.equalTo(30)
        }
    }
    func configureUI(){
        backgroundColor = .systemGray5
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
