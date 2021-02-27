//
//  SettingsViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 26.10.2020.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        deneme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        howManyTimesPosted()

        usernameLabel.text = userSingleton.sharedUserInfo.username
//        deneme()
    }

    @IBAction func changeClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toChangeVC", sender: nil)
    }
    
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toMainVC", sender: nil)
        }catch{
            print ("error")
        }
    }
    
    func makeAlert(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func howManyTimesPosted() {
        let db = Firestore.firestore()
        db.collection((Auth.auth().currentUser?.email!)!).getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                
                var count = 0
                for document in querySnapshot!.documents {
                    count += 1
                    print("\(document.documentID) => \(document.data())")
                }
                
                print("Count = \(count)")
                
                self.infoLabel.text = String("\(count) kere çöp attı.")
            }
        }
        
    }
//    func deneme() {
//        let db = Firestore.firestore()
//        db.collection("AllUserNames").document("0jJKHqyY46sqVyAINOKz").collection("deneme").getDocuments { (snapshot, err) in
//            if snapshot != nil {
//                for document in snapshot!.documents{
//                    print(document.documentID)
//                }
//            }
//        }
//    }
    
    func getUserNameFromFirebase()
    {
        let firestoredatabase = Firestore.firestore()
        firestoredatabase.collection("Usernames").whereField("email", isEqualTo: Auth.auth().currentUser?.email!).getDocuments { (snapshot, error) in
            if error != nil {
                self.makeAlert(alertTitle: "error" , alertMessage: error?.localizedDescription ?? "Error")
            }
            else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents{
                        if let userName = document.get("username") as? String{
                            userSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            userSingleton.sharedUserInfo.username = userName
                        }
                    }
                }
            }
        }
        
    }
    
}


 
