//
//  AboutNoteVC.swift
//  note_WinMachines_iOS
//
//  Created by user185555 on 2/4/21.
//

import UIKit

import UIKit
import MapKit
class AboutNoteVC: UITableViewController {
    var selectedNote : Notes?
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedNote)
        if let note =  selectedNote{
            let coordinates = CLLocationCoordinate2D(latitude: note.lat , longitude: note.long)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            mapView.region = region
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            mapView.addAnnotation(pin)
        }
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
