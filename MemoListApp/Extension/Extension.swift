//
//  Extension.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit

extension UIImageView {
    func makeLine(){
        self.backgroundColor = .lightGray
    }
}

extension UITextView { 
    func overview(){
        self.clipsToBounds = true
        self.backgroundColor = .systemGray5
        self.font = .systemFont(ofSize: 15, weight: .heavy)
    }
}

extension UITextField { 
    func titleTextField(){
        self.backgroundColor = .systemGray5
        self.placeholder = "제목"
        self.textColor = .black
        self.clipsToBounds = true
        self.font = .systemFont(ofSize: 15, weight: .heavy)
    }
}
