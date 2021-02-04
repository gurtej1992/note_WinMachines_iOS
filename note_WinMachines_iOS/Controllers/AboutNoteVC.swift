//
//  MoreinfoVCTableView.swift
//  note_WinMachines_iOS
//
//  Created by user185555 on 1/31/21.
//

import UIKit
import MapKit
class AboutNoteVC: UITableViewController {
    var selectedNote : Notes?
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}

