//
//  UIView+Extension.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set (value) {
            layer.cornerRadius = value > 0 ? value : 0
            layer.masksToBounds = true
        }
        
        get {
            layer.cornerRadius
        }
        
    }
    
    public func addSubView(view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.autoresizesSubviews = true
        
        addViewWithConstraints(insertView: view, containerView: self)
    }
    
    @discardableResult   // 1
        func fromNib<T : UIView>() -> T? {   // 2
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {    // 3
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)     // 4
        contentView.translatesAutoresizingMaskIntoConstraints = false   // 5
        contentView.layoutAttachAll(to: self)   // 6
        return contentView   // 7
    }
    
    public func layoutAttachAll(to childView:UIView)
        {
            var constraints = [NSLayoutConstraint]()

            childView.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(NSLayoutConstraint(item: childView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
            constraints.append(NSLayoutConstraint(item: childView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
            constraints.append(NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
            constraints.append(NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))

            childView.addConstraints(constraints)
        }
    
    private func addViewWithConstraints(insertView: UIView, containerView: UIView) {
        containerView.addSubview(insertView)
        insertView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: insertView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: insertView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let leading = NSLayoutConstraint(item: insertView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: insertView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        containerView.addConstraints([top, bottom, leading, trailing])
        containerView.layoutIfNeeded()
    }
}
