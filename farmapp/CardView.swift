//
//  CardView.swift
//  farmapp
//
//  Created by Fede Beron on 18/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit


@IBDesignable class CardView: UIView {

    @IBInspectable var cornerraduis : CGFloat = 2
    
    @IBInspectable var shadowOffSetWith : CGFloat = 2
    
    @IBInspectable var shadowOffSetHeight : CGFloat = 2
    
    @IBInspectable var shadowColor : UIColor = UIColor.black
    
    @IBInspectable var shadowOpacity : CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerraduis
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWith, height: shadowOffSetHeight)
        layer.shadowRadius = 5
        layer.shadowOpacity = Float(shadowOpacity)
    }
 
}
