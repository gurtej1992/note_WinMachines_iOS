//
//  NoteTableViewCell.swift
//  note_WinMachines_iOS
//
//  Created by Mac on 04/02/21.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
        @IBOutlet weak var shadowView : UIView!
        @IBOutlet weak var lblTitle : UILabel!
         @IBOutlet weak var lblDate : UILabel!
         @IBOutlet weak var lblDesc : UILabel!
        @IBOutlet weak var noteImageView: UIImageView!
        override func awakeFromNib() {
            super.awakeFromNib()
            shadowView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
            shadowView.layer.shadowRadius = 1.5
            shadowView.layer.shadowOpacity = 0.2
            shadowView.layer.cornerRadius = 2
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        func configureCell(with note: Notes){
            lblTitle.text = note.note_title
            lblDesc.text = note.note_content
            if let date = note.date_created{
                lblDate.text = Functions.createDate(from: date, with: "MMM d, yyyy", calender: true)
            }
            if let strImage = note.note_image{
                guard let imageurl = URL(string: strImage) else {return}
                guard let data = try? Data(contentsOf: imageurl) else {return}
                noteImageView.isHidden = false
                noteImageView.image = UIImage(data: data)
            }
            else{
                noteImageView.isHidden = true
            }
        }

    
}
