//
//  UploadViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 26.10.2020.
//

import UIKit
import Firebase
import GoogleMobileAds

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    var interstitial: GADInterstitial!
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
        
        commentText.delegate = self
        //tıklanabilir yaptık.
//        imageview.isUserInteractionEnabled = true
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
//        imageview.addGestureRecognizer(gestureRecognizer)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imageview.image = info[.originalImage] as? UIImage
//        self.dismiss(animated: true, completion: nil)
//    }
    
//    @objc func chooseImage(){
//
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        pickerController.sourceType = .photoLibrary
//        present(pickerController, animated: true, completion: nil)
//
//    }
//
    
    func makeAlert(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentText.resignFirstResponder()
        return(true)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        var firestoreReference : DocumentReference?
        
        let firestorePost = ["username" : userSingleton.sharedUserInfo.username, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0 , "likedBy" : "" ] as [String : Any]
        firestoreReference = firestoreDatabase.collection((Auth.auth().currentUser?.email!)!).addDocument(data: firestorePost)
        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data:firestorePost , completion: { (error) in
            if error != nil {
                self.makeAlert(alertTitle: "Error", alertMessage: error?.localizedDescription ??   "Error" )
            }
            else{
                if self.interstitial.isReady {
                    self.interstitial.present(fromRootViewController: self)
                  }
                self.commentText.text = ""
                self.tabBarController?.selectedIndex = 0
                
            }
        })
    }
    
}

       
//        let storage = Storage.storage()
//        let storageReference = storage.reference()
//        let uuid = UUID().uuidString
//        let mediaFolder = storageReference.child("media")
//
//        if let data = imageview.image?.jpegData(compressionQuality: 0.5){
//            let imageReference = mediaFolder.child("\(uuid).jpeg")
//            imageReference.putData(data, metadata: nil) { (metadata, error) in
//                if error != nil {
//                    self.makeAlert(alertTitle: "Yuklenemedi", alertMessage: error?.localizedDescription ?? "Error")
//                }else {
//                    imageReference.downloadURL { (url, error) in
//                        if error == nil {
//                            let imageURL = url?.absoluteString
//                            print(imageURL)
//
//                            //                            DATABASE
//
//
//                    }
//                }
//            }
//        }
//    }
//
 
