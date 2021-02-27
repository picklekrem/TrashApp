//
//  signupViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 26.10.2020.
//

import UIKit
import FirebaseAuth
import Firebase

class signupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        passwordText.delegate = self
        passwordAgainText.delegate = self
        username.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        passwordAgainText.resignFirstResponder()
        username.resignFirstResponder()
        return(true)
    }
    
    let firestoreReference : DocumentReference? = nil
    let firestoreDataBase = Firestore.firestore()
    
    @IBAction func signupClicked(_ sender: Any) {
        
        if emailText.text != "" {
            
            if passwordText.text != "" && passwordText.text == passwordAgainText.text{
                
                firestoreDataBase.collection("AllUserNames").whereField("usernames", isEqualTo: "\(username.text!)").getDocuments(){(querySnapshot, err) in
                    if querySnapshot?.isEmpty == true
                    {
                        Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordText.text!) { (authdata, error) in
                            if error != nil{
                                self.makeAlert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                            }
                            else{

                                let userDictinoary = ["email" : self.emailText.text!, "username": self.username.text!, "password" : self.passwordText.text, "Posted" : 0] as [String : Any]

                                let userNameDic = ["usernames" : self.username.text!] as [String : Any]

                                self.firestoreDataBase.collection("AllUserNames").addDocument(data: userNameDic)
                                self.firestoreDataBase.collection("Usernames").document(Auth.auth().currentUser!.email!).setData(userDictinoary) { (error) in
                                    if error != nil {
                                        //
                                    }
                                }
                                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                            }

                        }
                        
                    }
                    else {self.makeAlert(alertTitle: "Kullanıcı Adı hatası", alertMessage: "Başka bir kullanıcı adı seçiniz")}
                }
                
            }  else {self.makeAlert(alertTitle: "Şifre hatası", alertMessage: "Şifreler uyuşmuyor.")}
        }
        else{makeAlert(alertTitle: "E-mail hatası!", alertMessage: "Lütfen e-mail adresinizi giriniz.")}
        
    }
    
    func makeAlert(alertTitle: String, alertMessage: String)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

