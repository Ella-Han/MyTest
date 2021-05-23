//
//  ReceivedMessageCell.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import UIKit

class ReceivedMessageCell: UITableViewCell {
    
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!

    private var contentMessageView: ContentMessageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bubbleView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configure(viewModel: MessageItemViewModel) {
        senderNameLabel.text = viewModel.senderName
        
        contentMessageView = ContentMessageView(frame: bubbleView.bounds)
        contentMessageView.configure(viewModel: viewModel)
        bubbleView.addSubView(view: contentMessageView)
    }
}
