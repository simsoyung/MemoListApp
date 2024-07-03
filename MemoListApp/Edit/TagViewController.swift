//
//  TagViewController.swift
//  MemoListApp
//
//  Created by 심소영 on 7/3/24.
//

import UIKit
import SnapKit

final class TagViewController: BaseViewController {
    
    var tagResult: ((String) -> Void)?
    
    lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "#쇼핑", at: 0, animated: true)
        segment.insertSegment(withTitle: "#공부", at: 1, animated: true)
        segment.insertSegment(withTitle: "#청소", at: 2, animated: true)
        segment.insertSegment(withTitle: "#운동", at: 3, animated: true)
        segment.insertSegment(withTitle: "#약속", at: 4, animated: true)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tagResult?(self.segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    override func configureHierarchy() {
        view.addSubview(segmentControl)
    }
    override func configureConstraints() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }

    }
}
