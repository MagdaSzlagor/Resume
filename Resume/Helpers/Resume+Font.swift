//
//  Resume+Font.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

struct ResumeFont {
    let name: String
    static let helveticaNeue = ResumeFont(name: "HelveticaNeue")
    static let `default` = ResumeFont.helveticaNeue
    
    func regular(size: CGFloat) -> UIFont {
        return font(style: "", size: size)
    }
    
    func light(size: CGFloat) -> UIFont {
        return font(style: "-Light", size: size)
    }
    
    func bold(size: CGFloat) -> UIFont {
        return font(style: "-Bold", size: size)
    }
    
    func medium(size: CGFloat) -> UIFont {
        return font(style: "-Medium", size: size)
    }
    
    func italic(size: CGFloat) -> UIFont {
        return font(style: "-Italic", size: size)
    }
    
    private func font(style: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: "\(name)\(style)", size: size) {
            return font
        }
        fatalError("Font: \(name) does not have \"\(style)\" style.")
    }
}
