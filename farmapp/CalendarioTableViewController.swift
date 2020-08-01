//
//  CalendarioTableViewController.swift
//  farmapp
//
//  Created by Fede Beron on 11/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CodableFirebase

class CalendarioTableViewController: UITableViewController {
    
    var farmacias = [Farmacia]()
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 170
 
        let today = Date()
               self.view.backgroundColor = UIColor.white
            
               let db = Firestore.firestore()
               formatter.dateFormat = "MMMM d, yyyy"
               let result = formatter.string(from: today)
               formatter.dateFormat = "MMMM d, yyyy HH:mm:ss"
               let startDate = result + " " + "07:00:00"
               formatter.locale = Locale(identifier: "es")
               let startTime: Date = formatter.date(from: startDate) ?? Date(timeIntervalSince1970: 0)
               let startTimestamp: Timestamp = Timestamp(date: startTime)

                
               let docRef = db.collection("farmaciasDeTurno")
                               .whereField("fecha", isGreaterThanOrEqualTo: startTimestamp)
        
               docRef.getDocuments { (querySnapshot, error) in
                    if let err = error {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            let doc = document.get("farmacia") as? DocumentReference
                            let fecha = document.get("fecha") as? Date
                            self.formatter.dateFormat = "d MMMM, yyyy"
                            let dateAsString = self.formatter.string(from: fecha!)
                            self.addPharmacy(docuemntReference: doc!, date: dateAsString)
                                                    }
                    }
                
               }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    public func addPharmacy(docuemntReference value: DocumentReference, date dateDuty: String) {
         var farmacia: Farmacia = Farmacia()
          value.getDocument { (document, error) in
          if let document = document {
              farmacia = try! FirestoreDecoder().decode(Farmacia.self, from: document.data()!)
              if let coords = document.get("coordinates") {
                              let point = coords as! GeoPoint
                              farmacia.lat = point.latitude
                              farmacia.lng = point.longitude
                         }
              farmacia.date = dateDuty
              self.farmacias.append(farmacia)
              self.tableView.reloadData()
              print("farmacia: \(farmacia)")
            } else {
              print("Document does not exist")
            }
          }
      }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return farmacias.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CustomTableViewCell
      cell.lblName.textColor = UIColor.black
      cell.lblAddress.textColor = UIColor.black
        cell.date.textColor = UIColor.black
      cell.lblName.text = farmacias[indexPath.row].name
      cell.lblAddress.text = farmacias[indexPath.row].address
      cell.date.text = farmacias[indexPath.row].date
      let url = URL(string: farmacias[indexPath.row].img!)
      cell.imgLogo.load(url: url!)
        
      return cell
    }
    
  
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.backgroundColor = UIColor.clear
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 
