//
//  ChangeNameViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 30.11.2020.
//

import UIKit
import Firebase

class ChangeNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    let currentUsername = userSingleton.sharedUserInfo.username
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        infoLabel.text = ""
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        infoLabel.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return(true)
    }
    @IBAction func CheckButtonCliecked(_ sender: Any) {
        print(currentUsername)
        
        let firestoreDataBase = Firestore.firestore()
        
        firestoreDataBase.collection("Usernames").whereField("username", isEqualTo: nameTextField.text!).getDocuments(){(querySnapshot, err) in
            if querySnapshot?.isEmpty == true
            {
                firestoreDataBase.collection("Usernames").document(Auth.auth().currentUser!.email!).updateData(["username" : self.nameTextField.text!]) { (error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "Error")
                    }else{
                        print("sa")
                        self.makeAlert(alertTitle: "Kullanıcı Adı başarıyla değiştirildi", alertMessage: "yeni kullanıcı adınız h.o.")
                        userSingleton.sharedUserInfo.username = self.nameTextField.text!
                        self.infoLabel.text = "Kullanıcı adınız başarıyla değiştirilmiştir"
                    }
                }
                
            }
            else {self.makeAlert(alertTitle: "Kullanıcı Adı hatası", alertMessage: "Başka bir kullanıcı adı seçiniz")}
        } //burası end
        
    }
    
    func makeAlert(alertTitle: String, alertMessage: String)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateData () {
        let db = Firestore.firestore()
        
        db.collection("Posts").whereField("postedBy:", isEqualTo: Auth.auth().currentUser!.email!).setValue("postedBy", forKey: nameTextField.text!)
    }
    
}
