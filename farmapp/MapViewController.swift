//
//  MapViewController.swift
//  farmapp
//
//  Created by Fede Beron on 10/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var btnCerrar: UIButton!
    var farmacia: Farmacia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appleWQ = CLLocation(latitude: farmacia.lat!, longitude: farmacia.lng!)
        let regionRadius: CLLocationDistance = 1000.0
        let region = MKCoordinateRegion(center: appleWQ.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.title = farmacia.name
        //You can also add a subtitle that displays under the annotation such as
        annotation.subtitle = farmacia.address
        annotation.coordinate = appleWQ.coordinate
        mapView.addAnnotation(annotation)
    }
     
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("redenring")
    }
}
