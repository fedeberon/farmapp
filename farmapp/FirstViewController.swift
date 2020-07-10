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

    @IBOutlet weak var lblFarmaciaDeTurno: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        let formatter = DateFormatter()
        let result = formatter.string(from: Date())
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
            let model = try! FirestoreDecoder().decode(Farmacia.self, from: document.data()!)
            self.lblFarmaciaDeTurno.text = model.name
            self.lblDireccion.text = model.address
              print("Model: \(model)")
          } else {
              print("Document does not exist")
          }
        }
    
    }
}
