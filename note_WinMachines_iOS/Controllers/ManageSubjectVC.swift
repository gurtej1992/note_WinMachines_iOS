//
//  ManageSubjectVC.swift
//  note_WinMachines_iOS
//
//  Created by Mac on 04/02/21.
//

import UIKit

class ManageSubjectVC: UIViewController {
    var arrSubjects = [Subjects]()

    @IBOutlet weak var subjectCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSubjets()
    }
    func fetchSubjets() {
        if let subjects = AccessCoreData.fetchSubjects(){
            arrSubjects.removeAll()
            arrSubjects = subjects
            subjectCV.reloadData()
        }
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleAddSubject(_ sender: Any) {
        showInputDialog(title: "Enter Subject", inputPlaceholder: "Subject Name", inputKeyboardType: .default, actionHandler:  { (string) in
            if let subject = string{
                AccessCoreData.addSubject(subjectName: subject)
                self.fetchSubjets()
            }
        })
    }
    
}
extension ManageSubjectVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSubjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCVC", for: indexPath) as! SubjectCVC
        cell.lblSubectName.text = arrSubjects[indexPath.row].subjectName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSubject = arrSubjects[indexPath.row]
        showInputDialog(title: "Update Subject", inputPlaceholder: "Subject Name", text: selectedSubject.subjectName, inputKeyboardType: .default, actionHandler:  { (string) in
            if let subject = string{
                selectedSubject.subjectName = subject
                AccessCoreData.saveCoreData()
                self.fetchSubjets()
            }
        })
    }
}
