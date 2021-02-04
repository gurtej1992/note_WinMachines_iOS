//
//  NoteVC.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//

import UIKit
import CoreLocation

class NoteVC: UIViewController {
    @IBOutlet weak var playerButtonImg: UIButton!
    @IBOutlet weak var buttonSave : UIButton!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var noteImg: UIImageView!
    @IBOutlet weak var btnRemoveRecording: UIButton!
    @IBOutlet weak var txtContent: UITextView!
    var imagePicker = UIImagePickerController()
    var selectedNote: Notes?
    var locationManager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = selectedNote {
            txtTitle.text = note.note_title
            txtContent.text = note.note_content
            buttonSave.setTitle("Update", for: .normal)
        }
        else{
            buttonSave.setTitle("Save", for: .normal)
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        imageView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
//        imageView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
//        imageView.layer.shadowRadius = 1.5
//        imageView.layer.shadowOpacity = 0.7
//        imageView.layer.cornerRadius = 2
//        imageView.clipsToBounds = true
//        //noteView.addShadow()
//        imageView.layer.masksToBounds = false
//        noteView.setCardView()
        // Do any additional setup after loading the view.
    }
    @IBAction func handlePlayerButton(_ sender: UIButton) {
    }
    @IBAction func handleRemoveRecording(_ sender: UIButton) {
        self.playerView.isHidden = true
    }
    @IBAction func HandleInsertImage(_ sender: UIButton) {
    }
    @IBAction func handleSave(_ sender: UIButton) {
        if sender.title(for: .normal) == "Save"{
            let note = Notes(context: AccessCoreData.context)
            note.note_title = txtTitle.text
            note.note_content = txtContent.text
            note.date_created = Date()
            note.lat  = userLocation?.latitude ?? 0
            note.long  = userLocation?.longitude ?? 0
        }
        else{
            if let note = selectedNote{
                note.note_title = txtTitle.text
                note.note_content = txtContent.text
                note.date_modified = Date()
                note.lat  = userLocation?.latitude ?? 0
                note.long  = userLocation?.longitude ?? 0
            
            }
        }
        AccessCoreData.saveCoreData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func handleAttachement(_ sender: UIButton) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        if imageView.isHidden == true{
            let cameraAction: UIAlertAction = UIAlertAction(title: "Image From Camera", style: .default) { action -> Void in
                self.handleCamera()
            }

            let mediaAction: UIAlertAction = UIAlertAction(title: "Image From Gallary", style: .default) { action -> Void in

                self.handlePhotoLibrary()
            }
            actionSheetController.addAction(cameraAction)
            actionSheetController.addAction(mediaAction)
        }
        else{
            let removeAction = UIAlertAction(title: "Remove Image", style: .destructive, handler: { (action) in
                self.imageView.isHidden = true
                self.noteImg.image = nil
            })
            actionSheetController.addAction(removeAction)
        }
       
        let micAction = UIAlertAction(title: "Add Recording", style: .default) { action -> Void in
            if self.playerView.isHidden == true{
                self.playerView.isHidden = false
            }
            else{
                self.playerView.isHidden = true
            }
            
        }
        

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        
        actionSheetController.addAction(micAction)
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func handleCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        else{
            print("Camera not available0")
        }
       

    }

    func handlePhotoLibrary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)

    }
}
extension NoteVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.isHidden = false
        if let image = info[.editedImage] as? UIImage {
            noteImg.image = image
            
        }
        else if let image = info[.originalImage] as? UIImage {
            noteImg.image = image
        } else {
            print("Other source")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
extension NoteVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first?.coordinate{
            userLocation = loc
        }
        print(locations[0])
    }
}
