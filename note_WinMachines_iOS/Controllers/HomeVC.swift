//
//  HomeVC.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//

import UIKit

class HomeVC: UIViewController {
    var arrNotes = [Notes]()
    var arrFilterNotes = [Notes]()
    var isSubjectSelected = false
    
    @IBOutlet weak var allNotesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if !isSubjectSelected {getNotes()}
    }
    func getNotes(){
        if let notes = AccessCoreData.fetchNotes(){
            arrNotes.removeAll()
            arrNotes = notes
            allNotesTV.reloadData()
        }
    }
    @IBAction func handleManageSubjects(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: Constants.ManageSubjectVC) as? ManageSubjectVC{
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func handleAdd(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(identifier: Constants.NoteVC){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension HomeVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notes = isSubjectSelected ? arrFilterNotes : arrNotes
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notes = isSubjectSelected ? arrFilterNotes[indexPath.row] : arrNotes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NoteTableViewCell, for: indexPath) as! NoteTableViewCell
        cell.configureCell(with: notes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let notes = isSubjectSelected ? arrFilterNotes[indexPath.row] : arrNotes[indexPath.row]
            AccessCoreData.deleteNote(note: notes)
            getNotes()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: Constants.NoteVC) as? NoteVC{
            let notes = isSubjectSelected ? arrFilterNotes[indexPath.row] : arrNotes[indexPath.row]
            vc.selectedNote = notes
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Info") { (act, view, bol) in
            if let vc = self.storyboard?.instantiateViewController(identifier: Constants.AboutNoteVC) as? AboutNoteVC{
                let notes = self.isSubjectSelected ? self.arrFilterNotes[indexPath.row] : self.arrNotes[indexPath.row]
                vc.selectedNote = notes
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        let swipe  =  UISwipeActionsConfiguration(actions: [action])
        return swipe
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
//extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        arrNotes.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
    
    
}

extension HomeVC : SubjectSelectionDelegate{
    func subjectSelected(is subject: Subjects) {
        isSubjectSelected = true
        arrFilterNotes = AccessCoreData.fetchNotesWithPredicate(predicate: NSPredicate(format: "subject.subjectName = %@", subject.subjectName!))!
        allNotesTV.reloadData()
    }
}
