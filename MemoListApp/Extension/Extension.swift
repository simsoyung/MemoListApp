//
//  Extension.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit

extension UILabel {
    func cellLabel(size: CGFloat, fontWeight: UIFont.Weight, color: UIColor) {
        self.numberOfLines = 0
        self.font = .systemFont(ofSize: size, weight: fontWeight)
        self.textColor = color
    }
}

extension UIImageView {
    func makeLine(){
        self.backgroundColor = .lightGray
    }
}

extension UITextView { 
    func overview(){
        self.clipsToBounds = true
        self.backgroundColor = .systemGray6
        self.font = .systemFont(ofSize: 15, weight: .medium)
        self.textColor = .lightGray
    }
}

extension UITextField { 
    func titleTextField(){
        self.backgroundColor = .systemGray6
        self.placeholder = "제목"
        self.textColor = .darkGray
        self.clipsToBounds = true
        self.font = .systemFont(ofSize: 15, weight: .medium)
    }
}

extension UITableViewCell {
    static var id: String {
       return String(describing: self)
    }
}


extension UIButton {
    func settingButton(text: String, imageName: String){
        self.configuration?.title = text
        self.configuration?.image = UIImage(systemName: imageName)
        self.configuration?.baseForegroundColor = .darkGray
        self.configuration?.imagePadding = 10
        self.configuration?.imagePlacement = .leading
        self.contentHorizontalAlignment = .center
    }
}
