//
//  HomeVC.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//

import UIKit

class HomeVC: UIViewController {
    var arrNotes = [Notes]()
    @IBOutlet weak var allNotesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let notes = AccessCoreData.fetchNotes(){
            arrNotes = notes
            allNotesTV.reloadData()
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
        return arrNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomeTableViewCell, for: indexPath)
        cell.textLabel?.text = arrNotes[indexPath.row].note_title
        return cell
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


