//
//  HomeVC.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnSubject: UIButton!
    var arrNotes = [Notes]()
    var arrFilterNotes = [Notes]()
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    var usingSearch = false
    @IBOutlet weak var allNotesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
     
            getNotes()
        
    }
    func getNotes(){
        if btnCross.isHidden == true{
            if let notes = AccessCoreData.fetchNotes(){
                arrNotes.removeAll()
                arrNotes = notes
                allNotesTV.reloadData()
            }
        }
        else{
            allNotesTV.reloadData()
        }
       
    }
    @IBAction func handleAllSubjects(_ sender: Any) {
        btnCross.isHidden = true
        btnSubject.isHidden = false
        getNotes()
    }
    @IBAction func handleSearch(_ sender: Any) {
        view.layoutIfNeeded()
        if searchBarHeight.constant == 0{
            
            searchBarHeight.constant = 56
        }
        else{
            searchBarHeight.constant = 0
            usingSearch = false
            allNotesTV.reloadData()
        }
        UIView.animate(withDuration:   0.5, animations: {
            self.view.layoutIfNeeded()
        })
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
        let notes = usingSearch ? arrFilterNotes : arrNotes
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notes = usingSearch ? arrFilterNotes[indexPath.row] : arrNotes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NoteTableViewCell, for: indexPath) as! NoteTableViewCell
        cell.configureCell(with: notes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let notes = usingSearch ? arrFilterNotes[indexPath.row] : arrNotes[indexPath.row]
            AccessCoreData.deleteNote(note: notes)
            getNotes()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: Constants.NoteVC) as? NoteVC{
            let notes = usingSearch ? arrFilterNotes[indexPath.row] : arrNotes[indexPath.row]
            vc.selectedNote = notes
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Info") { (act, view, bol) in
            if let vc = self.storyboard?.instantiateViewController(identifier: Constants.AboutNoteVC) as? AboutNoteVC{
                let notes = self.usingSearch ? self.arrFilterNotes[indexPath.row] : self.arrNotes[indexPath.row]
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
    
}

extension HomeVC : SubjectSelectionDelegate{
    func subjectSelected(is subject: Subjects?) {
        if let sub = subject{
            arrNotes = AccessCoreData.fetchNotesWithSubject(subject: sub)!
            btnCross.isHidden = false
            btnSubject.isHidden = true
            allNotesTV.reloadData()
        }
       
    }
}
extension HomeVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        usingSearch = true
        arrFilterNotes.removeAll()
        arrFilterNotes =  Array(Set(arrNotes.filter({($0.note_title?.contains(searchText))!}) + arrNotes.filter({($0.note_content?.contains(searchText))!})))
        allNotesTV.reloadData()
    }
}
