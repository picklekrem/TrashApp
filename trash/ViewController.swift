//
//  ViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 26.10.2020.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet var googleSingInButton: GIDSignInButton!
    @IBOutlet weak var welcomeText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        passwordText.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        print("selam1")
//        if commentSing.sharedCommentInfo.segue == true {
//            performSegue(withIdentifier: "toFeedVC", sender: nil)
//            print("selam2")
//        }
        
        welcomeText.font = UIFont(name: "Blacklisted", size: 35)
    }
    override func viewWillAppear(_ animated: Bool) {
//        print("selam3")
//        if commentSing.sharedCommentInfo.segue == true {
//            print("selam4")
//            performSegue(withIdentifier: "toFeedVC", sender: nil)
//        }
    }

    let firestoreDataBase = Firestore.firestore()
    var firestoreReference : DocumentReference? = nil
    var username = ""
    
    @IBAction func signingoogleclicked(_ sender: Any) {
//        performSegue(withIdentifier: "toFeedVC", sender: nil)
        print("çalışmıyor")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return(true)
    }
    
    @IBAction func signinClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                }
                else
                {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(alertTitle: "Kullanıcı adı / Şifre hatası", alertMessage: "Lütfen kontrol ediniz")
        }
    }
    

    
    @IBAction func signupClicked(_ sender: Any) {

        self.performSegue(withIdentifier: "toSignupVC", sender: nil)
    }
    
    func makeAlert(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
}

