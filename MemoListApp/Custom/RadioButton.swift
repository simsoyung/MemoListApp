//
//  RadioButton.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit

class RadioButton: UIButton {

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
            } else {
                self.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(systemName: "circle"), for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        if !self.isSelected {
            self.isSelected = true
        }
    }
}
