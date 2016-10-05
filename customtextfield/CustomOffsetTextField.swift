//
//  CustomOffsetTextField.swift
//  customtextfield
//
//  Created by Mudasir Ahmed on 10/5/16.
//  Copyright © 2016 Mudasir Ahmed. All rights reserved.
//

import UIKit

@IBDesignable
class CustomOffsetTextField: UITextField {
    
    // offset
    @IBInspectable var textOffset: CGPoint = .zero
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // left view
    private var leftViewOffset: CGFloat {
        let leftViewRect = self.leftViewRect(forBounds: bounds)
        return leftViewRect.width
    }

    /**
     It is technically possible for both a right view and clear button to be showing. However, the system renders them on top of each other.
     Because of that, this computed property just returns the larger of the 2 widths.
     */
    private var rightViewOffset: CGFloat {
        let rightViewRect = self.rightViewRect(forBounds: bounds)
        let clearRect = self.clearButtonRect(forBounds: bounds)
        return (rightViewRect.width > clearRect.width) ? rightViewRect.width : clearRect.width
    }
    
    // override the rects
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }

    
    /**
     Adjusts the origins and size of the given rect, accounting for specified custom offsets as well as the sizes of left views, right views, and clear buttons.
     
     - parameter bounds: the rect to adjust
     
     - returns: a rect adjusted to account for the above mentioned factors.
     */
    private func adjustedRect(forBounds bounds: CGRect) -> CGRect {
        
        var newRect = bounds
        newRect.origin.x += (textOffset.x + leftViewOffset)
        newRect.origin.y += textOffset.y
        newRect.size.width -= (textOffset.x + leftViewOffset + rightViewOffset)
        return newRect
    }
}
