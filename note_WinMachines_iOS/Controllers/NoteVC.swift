//
//  NoteVC.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//

import UIKit

class NoteVC: UIViewController {
    @IBOutlet weak var playerButtonImg: UIButton!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var noteImg: UIImageView!
    @IBOutlet weak var btnRemoveRecording: UIButton!
    @IBOutlet weak var txtContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        imageView.layer.shadowRadius = 1.5
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        //noteView.addShadow()
        imageView.layer.masksToBounds = false
        noteView.setCardView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePlayerButton(_ sender: UIButton) {
    }
    @IBAction func handleRemoveRecording(_ sender: UIButton) {
    }
    @IBAction func HandleInsertImage(_ sender: UIButton) {
    }
    
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
