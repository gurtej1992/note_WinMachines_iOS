//
//  AboutNoteVC.swift
//  note_WinMachines_iOS
//
//  Created by user185555 on 2/4/21.
//

import UIKit
import MapKit
class AboutNoteVC: UITableViewController {
    var selectedNote : Notes?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note =  selectedNote{
            let coordinates = CLLocationCoordinate2D(latitude: note.lat , longitude: note.long)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            mapView.region = region
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            mapView.addAnnotation(pin)
            
            let geo = CLGeocoder()
            
            geo.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { (placeMark, err) in
                if placeMark?.count != nil{
                    if let placeMark = placeMark?.first{
                        let Marker = MKPointAnnotation()
                        Marker.coordinate = coordinates
                        Marker.title = placeMark.name
                        self.lblLocation.text = "\(placeMark.name ?? "")"
                        self.mapView.addAnnotation(Marker)
                        
                    }
                }
        }
        }
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (tableView.frame.height * 80) / 100
        }
        else{
            return tableView.estimatedRowHeight
        }
    }
}
