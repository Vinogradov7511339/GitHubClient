//
//  TextStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.07.2021.
//

import Foundation
import UIKit

class TextStorage: NSTextStorage {
    
    let innerAttributedString = NSMutableAttributedString()
    
    override var string: String { innerAttributedString.string }
    
    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key : Any] {
        return innerAttributedString.attributes(at: location, effectiveRange: range)
    }
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        beginEditing()
        innerAttributedString.replaceCharacters(in: range, with: str)
        edited(.editedCharacters, range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    override func setAttributes(_ attrs: [NSAttributedString.Key : Any]?, range: NSRange) {
        beginEditing()
        innerAttributedString.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
}
