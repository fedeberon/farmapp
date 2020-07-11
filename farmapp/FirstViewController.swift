//
//  FirstViewController.swift
//  farmapp
//
//  Created by Fede Beron on 08/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit

import FirebaseFirestore
import CodableFirebase
 
class FirstViewController: UIViewController {
    @IBOutlet weak var btnVerEnMapa: UIButton!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblFarmaciaDeTurno: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    var farmacia: Farmacia = Farmacia()
    let formatter = DateFormatter()
 
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let today = Date()
        formatter.locale = Locale(identifier: "es-AR")
        formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        let hoy = formatter.string(from: today)
        self.title = "Turno Hoy "  + hoy
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        formatter.dateFormat = "MMMM d, yyyy"
        let result = formatter.string(from: today)
        formatter.dateFormat = "MMMM d, yyyy HH:mm:ss"
        let startDate = result + " " + "07:00:00"
        let endDate = result + " " + "23:00:00"
        let startTime: Date = formatter.date(from: startDate) ?? Date(timeIntervalSince1970: 0)
        let startTimestamp: Timestamp = Timestamp(date: startTime)

        let endTime: Date = formatter.date(from: endDate) ?? Date()
        let endTimestamp: Timestamp = Timestamp(date: endTime)

        let docRef = db.collection("farmaciasDeTurno")
                        .whereField("fecha", isGreaterThanOrEqualTo: startTimestamp)
                        .whereField("fecha", isLessThanOrEqualTo: endTimestamp)
        docRef.getDocuments { (querySnapshot, error) in
             if let err = error {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                     print("\(document.documentID) => \(document.data())")
                    let doc = document.get("farmacia") as? DocumentReference
                    self.showPharmacy(docuemntReference: doc!)
                 }
             }
        }
    }
    
     public func showPharmacy(docuemntReference value: DocumentReference){
        value.getDocument { (document, error) in
        if let document = document {
            self.farmacia = try! FirestoreDecoder().decode(Farmacia.self, from: document.data()!)
            if let coords = document.get("coordinates") {
                            let point = coords as! GeoPoint
                            let lat = point.latitude
                            let lon = point.longitude
                            self.farmacia.lat = point.latitude
                            self.farmacia.lng = point.longitude
                            print(lat, lon) //here you can let coor = CLLocation(latitude: longitude:)
                       }
            self.lblFarmaciaDeTurno.textColor = UIColor.black
            self.lblFarmaciaDeTurno.text = self.farmacia.name
            self.lblDireccion.textColor = UIColor.black
            self.lblDireccion.text = self.farmacia.address
            let url = URL(string: self.farmacia.img!)
            self.imageView.load(url: url!)
            
            
            print("farmacia: \(self.farmacia)")
          } else {
            print("Document does not exist")
          }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let controller = segue.destination as! MapViewController
            controller.farmacia = self.farmacia
        }
    }
    
    @IBAction func callPhoneFarmacia(_ sender: Any) {
        callNumber(phoneNumber: self.farmacia.phoneNumber!)
    }
    
    private func callNumber(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let date = Date()
        let msg = "Hi my dear friends\(date)"
        let urlWhats = "whatsapp://send?phone=\(self.farmacia.phoneNumber!)&text=\(msg)"

        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("please install watsapp")
                }
            }
        }
        
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
