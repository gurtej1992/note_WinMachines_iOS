//
//  Functions.swift
//  note_WinMachines_iOS
//
//  Created by Mac on 03/02/21.
//

import UIKit

class Functions: NSObject {
static func createDate(from date : Date, with format : String, calender : Bool = false) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    if calender{
        let calendar = Calendar.current
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else{
            dateFormatter.string(from: date)
        }
    }
    return dateFormatter.string(from: date)
}
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
extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         text:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.text = text
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))

        self.present(alert, animated: true, completion: nil)
    }
}
extension UIImage {

    func isEqualToImage(_ image: UIImage) -> Bool {
           let data1 = self.pngData()
           let data2 = image.pngData()
           return data1 == data2
       }

}
