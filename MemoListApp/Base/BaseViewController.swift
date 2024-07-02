//
//  BaseViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift
import Toast

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
    }
     
    func configureHierarchy() {
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
    }

}
