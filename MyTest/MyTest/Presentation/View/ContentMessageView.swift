//
//  ContentMessageView.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import UIKit

class ContentMessageView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: Override functions

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
        addSubView(view: view)
    }

    private func loadViewFromNib() {
        Bundle.main.loadNibNamed("ContentMessageView", owner: self, options: nil)
        addSubView(view: view)
    }
    
    func configure(viewModel: MessageItemViewModel) {
        messageLabel.text = viewModel.message
    }
    
    func reset() {
        messageLabel.text = nil
    }
}
