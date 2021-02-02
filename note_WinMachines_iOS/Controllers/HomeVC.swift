//
//  HomeVC.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var allNotesCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleAdd(_ sender: UIBarButtonItem) {
    }
}
extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

