//
//  TextField.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import SnapKit

class TextFieldView: UIView {
    
    let nameTextField = UITextField()
    let contentTextView = UITextView()
    let imageLineView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        addSubview(nameTextField)
        addSubview(contentTextView)
        addSubview(imageLineView)
        contentTextView.delegate = self
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    func configureLayout(){
        nameTextField.snp.makeConstraints { make in
            make.top.trailing.equalTo(self).inset(10)
            make.leading.equalTo(self).inset(30)
            make.height.equalTo(40)
        }
        imageLineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.trailing.equalTo(self).inset(10)
            make.leading.equalTo(self).inset(30)
            make.height.equalTo(1)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.trailing.equalTo(self).inset(10)
            make.leading.equalTo(self).inset(30)
            make.height.equalTo(150)
        }
    }
    func configureUI(){
        nameTextField.titleTextField()
        contentTextView.overview()
        imageLineView.makeLine()
        backgroundColor = .systemGray6
        contentTextView.text = "메모"
        contentTextView.textColor = .lightGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension TextFieldView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
