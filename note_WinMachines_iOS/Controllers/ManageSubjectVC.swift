//
//  ManageSubjectVC.swift
//  note_WinMachines_iOS
//
//  Created by Mac on 04/02/21.
//

import UIKit
protocol SubjectSelectionDelegate {
    func subjectSelected(is subject : Subjects?)
}
class ManageSubjectVC: UIViewController {
    var arrSubjects = [Subjects]()
    var delegate : SubjectSelectionDelegate?
    @IBOutlet weak var subjectTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSubjets()
    }
    func fetchSubjets() {
        if let subjects = AccessCoreData.fetchSubjects(){
            arrSubjects.removeAll()
            arrSubjects = subjects
            subjectTV.reloadData()
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
    
    func updateSubject(selectedSubject : Subjects){
        showInputDialog(title: "Update Subject", actionTitle: "Update", inputPlaceholder: "Subject Name", text: selectedSubject.subjectName, inputKeyboardType: .default, actionHandler:  { (string) in
            if let subject = string{
                selectedSubject.subjectName = subject
                AccessCoreData.saveCoreData()
                self.fetchSubjets()
            }
        })
    }
    
   @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        if sender.state == .began {

            let touchPoint = sender.location(in: self.subjectTV)
            if let indexPath = subjectTV.indexPathForRow(at: touchPoint) {
                updateSubject(selectedSubject: arrSubjects[indexPath.row])
            }
    }
    }
    
}
extension ManageSubjectVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPressed(sender:)))
            
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrSubjects[indexPath.row].subjectName
        cell.addGestureRecognizer(longPressRecognizer)
        let count = AccessCoreData.fetchNotesWithSubject(subject: arrSubjects[indexPath.row])?.count ?? 0
        cell.detailTextLabel?.text = "Total Notes \(count)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.subjectSelected(is: arrSubjects[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            delegate?.subjectSelected(is: nil)
            AccessCoreData.deleteSubject(subjectSubject: arrSubjects[indexPath.row])
            fetchSubjets()
        }
    }
    
    
}
