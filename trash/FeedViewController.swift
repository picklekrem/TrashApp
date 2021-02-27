//
//  FeedViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 26.10.2020.
//
import Firebase
import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableviewController: UITableView!
    
    var userEmailArray = [String] ()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userimageArray = [String]()
    var documentIdArray = [String]()
    var usernameIdArray = [String]()
    
    
    
    let firestoredatabase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewController.delegate = self
        tableviewController.dataSource = self
        
        getUserNameFromFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserNameFromFirebase()
        getDataFromFirestore()
        
    }
   
    func getUserNameFromFirebase()
    {
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

    func getDataFromFirestore(){
        
        
        firestoredatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }else{
                if snapshot?.isEmpty != nil {
                    self.userimageArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    self.usernameIdArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)

                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageURL = document.get("imageURL") as? String {
                            self.userimageArray.append(imageURL)
                        }
                        if let username = document.get("username") as? String{
                            self.usernameIdArray.append(username)
                        }
                        
                    }
                    self.tableviewController.reloadData()
                }
            }
            
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section Title \(section)"
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        header.backgroundColor = .none
        let imageview = UIImageView(image: UIImage(named: "trashh"))
        imageview.tintColor = .systemBlue
        imageview.contentMode = .scaleAspectFit
        header.addSubview(imageview)
        imageview.frame = CGRect(x: 5, y: 5, width: header.frame.size.height-10, height: header.frame.size.height-10)
        
        
        let label = UILabel(frame: CGRect(x: 5 + imageview.frame.size.width, y: 20,
                                          width: header.frame.size.width - 15 - imageview.frame.size.width,
                                          height: header.frame.size.height-10))
        header.addSubview(label)
        label.text = "rash!"
        label.font = UIFont(name: "Blacklisted", size: 50)
        return header
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableviewController.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
//        cell.emailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = ("\(userCommentArray[indexPath.row]) çöpe attı.")
        cell.likelabel.text = String(likeArray[indexPath.row])
        cell.documentidlabel.text = String(documentIdArray[indexPath.row])
        cell.emailLabel.text = usernameIdArray[indexPath.row]
//        cell.profilepicimage.image = UIImage(named: "game.jpeg")
//        cell.imageviewcell.image = UIImage()
        return cell
    }
    
    func makeAlert(alertTitle: String, alertMessage: String)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
