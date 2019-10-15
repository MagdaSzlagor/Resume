//
//  UIView+Autolayout.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

enum Edge {
    case top
    case left
    case bottom
    case right
    
    var layoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}


extension UIView {
    
    func pinEdges(_ edges: [Edge], to view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required, relatedBy relation: NSLayoutConstraint.Relation = .equal) {
        for edge in edges {
            switch edge {
            case .top: pinTop(to: view, constant: constant, priority: priority, relatedBy: relation)
            case .left: pinLeft(to: view, constant: constant, priority: priority, relatedBy: relation)
            case .bottom: pinBottom(to: view, constant: constant, priority: priority, relatedBy: relation)
            case .right: pinRight(to: view, constant: constant, priority: priority, relatedBy: relation)
            }
        }
    }
    
    @discardableResult func pinTop(to view: UIView,
                                   constant: CGFloat = 0,
                                   priority: UILayoutPriority = UILayoutPriority.required,
                                   relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return pin(edge: .top, to:.top, of: view, constant: constant, priority: priority, relatedBy: relation)
    }
    
    @discardableResult func pinBottom(to view: UIView,
                                      constant: CGFloat = 0,
                                      priority: UILayoutPriority = UILayoutPriority.required,
                                      relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return pin(edge: .bottom, to:.bottom, of: view, constant: constant, priority: priority, relatedBy: relation)
    }
    
    @discardableResult func pinLeft(to view: UIView,
                                    constant: CGFloat = 0,
                                    priority: UILayoutPriority = UILayoutPriority.required,
                                    relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return pin(edge: .left, to:.left, of: view, constant: constant, priority: priority, relatedBy: relation)
    }
    
    @discardableResult func pinRight(to view: UIView,
                                     constant: CGFloat = 0,
                                     priority: UILayoutPriority = UILayoutPriority.required,
                                     relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return pin(edge: .right, to:.right, of: view, constant: constant, priority: priority, relatedBy: relation)
    }
    
    @discardableResult func pin(edge: Edge,
                                to otherEdge: Edge,
                                of view: UIView,
                                constant: CGFloat = 0,
                                priority: UILayoutPriority = UILayoutPriority.required,
                                relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        if view !== superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: edge.layoutAttribute,
                                            relatedBy: relation,
                                            toItem: view,
                                            attribute: otherEdge.layoutAttribute,
                                            multiplier: 1,
                                            constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
}

// MARK: Size Constraint
extension UIView {
    
    @discardableResult func addWidthConstraint(with constant: CGFloat,
                                               priority: UILayoutPriority = UILayoutPriority.required,
                                               relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: relation,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
        
    }
    
    @discardableResult func addHeightConstraint(with constant: CGFloat,
                                                priority: UILayoutPriority = UILayoutPriority.required,
                                                relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: relation,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
        
    }
    
}

// MARK: Center superview
extension UIView {
    
    @discardableResult func centerYToSuperview(withConstant constant: CGFloat = 0,
                                               priority: UILayoutPriority = UILayoutPriority.required,
                                               relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: relation,
                                            toItem: superview,
                                            attribute: .centerY,
                                            multiplier: 1,
                                            constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func centerXToSuperview(withConstant constant: CGFloat = 0,
                                               priority: UILayoutPriority = UILayoutPriority.required,
                                               relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: relation,
                                            toItem: superview,
                                            attribute: .centerX,
                                            multiplier: 1,
                                            constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
}
