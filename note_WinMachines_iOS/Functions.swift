//
//  Functions.swift
//  note_WinMachines_iOS
//
//  Created by Mac on 03/02/21.
//

import UIKit

class Functions: NSObject {

}
extension UIView{
    func addShadow(){
        self.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = 2
    }
}
extension UIView {

    func setCardView(){
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        layer.masksToBounds = true
    }
}
