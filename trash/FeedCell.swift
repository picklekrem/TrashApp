//
//  FeedCell.swift
//  trash
//
//  Created by Ekrem Özkaraca on 29.10.2020.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var likelabel: UILabel!
    
    @IBOutlet weak var documentidlabel: UILabel!
    @IBOutlet weak var profilepicimage: UIImageView!
    @IBOutlet weak var imageviewcell: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var unlikebutton: UIButton!
    @IBOutlet weak var likebutton: UIButton!
    
    
    var likearray = [String]()
    var sayi = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likelabel.font = UIFont(name: "Vogue", size: 30)
        
    }
    
//    func howManyTimesPosted() {
//        let db = Firestore.firestore()
//        print("\(Auth.auth().currentUser!.email)")
//
//
//        db.collection("Posts").whereField("", isEqualTo: true ).getDocuments { (snapshot, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "Error dude")
//            }else{
//                for document in snapshot!.documents {
//                    print("\(document.documentID)")
//                }
//            }
//        }
//
//
//        db.collection((Auth.auth().currentUser?.email!)!).getDocuments()
//        {
//            (querySnapshot, err) in
//
//            if let err = err
//            {
//                print("Error getting documents: \(err)")
//            }
//            else
//            {
//
//                var count = 0
//                for document in querySnapshot!.documents {
//                    count += 1
//                    if count >= 2 {
//                        self.backgroundColor = UIColor(patternImage: UIImage(named: "kagit")!)
//                        if count >= 5 {
//                            self.backgroundColor = UIColor(patternImage: UIImage(named: "kagit4")!)
//                        }
//                    }
//
//                }
//            }
//        }
//
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func commentButtonClicked(_ sender: Any) {
       
    }
    
    let firestoreDatabase = Firestore.firestore()
    
    @IBAction func unLikeButtonClicked(_ sender: UIButton) {
        if let countNumber = Int(likelabel.text!){
            
            let likeStore = ["likes" : countNumber - 1] as [String : Any]
            let likedBy = ["likedBy" : ""] as [String : Any]
            firestoreDatabase.collection("Posts").document(documentidlabel.text!).setData(likedBy, merge: true)
            firestoreDatabase.collection("Posts").document(documentidlabel.text!).setData(likeStore, merge: true)
            sender.isHidden = true
            likebutton.isHidden = false
            
            
            let denemeref = firestoreDatabase.collection("Usernames").document(Auth.auth().currentUser!.email!)
            denemeref.updateData(["Posts that i like" : FieldValue.arrayRemove([documentidlabel.text!])])

        
    }
    }
    @IBAction func likebuttonClicked(_ sender: UIButton) {
        
        if let countNumber = Int(likelabel.text!){
            
            let likeStore = ["likes" : countNumber + 1] as [String : Any]
            let likedBy = ["likedBy" : ""] as [String : Any]
            
            firestoreDatabase.collection("Posts").document(documentidlabel.text!).setData(likedBy, merge: true)
            firestoreDatabase.collection("Posts").document(documentidlabel.text!).setData(likeStore, merge: true)
            sender.isHidden=true
            unlikebutton.isHidden=false
            
            
            
            let denemeref = firestoreDatabase.collection("Usernames").document(Auth.auth().currentUser!.email!)
            denemeref.updateData(["Posts that i like" : FieldValue.arrayUnion([documentidlabel.text!])])

        }
        
    }
    
    func butonlama () {
        
        firestoreDatabase.collection("Usernames").whereField("Posts that i like", isEqualTo: true).getDocuments(){(querySnaphot, err) in
            if let err = err {
                print("Error ")
            }
            else
            {
                for document in querySnaphot!.documents{
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
    }
}
    

