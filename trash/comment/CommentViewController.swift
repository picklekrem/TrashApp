//
//  CommentViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 9.11.2020.
//

import UIKit
import Firebase

class CommentViewController: UIViewController {

    @IBOutlet weak var emailtext: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var documentidArray = [String]()
    
    let firestoreDatabase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    @IBAction func commentButtonClick(_ sender: Any) {
//        self.tabBarController?.selectedIndex = 1
    }
    

}
