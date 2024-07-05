//
//  MemoCollectionViewCell.swift
//  MemoListApp
//
//  Created by 심소영 on 7/4/24.
//

import UIKit
import SnapKit

class MemoCollectionViewCell: UICollectionViewCell {
    static let id = "MemoCollectionViewCell"
    
    let collectionCell = MainTypeView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { 
        contentView.addSubview(collectionCell)
    }
    func configureLayout() {
        collectionCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureView() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
