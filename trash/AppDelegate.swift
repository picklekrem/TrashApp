//
//  AppDelegate.swift
//  trash
//
//  Created by Ekrem Özkaraca on 26.10.2020.
//

import UIKit
import Firebase
import GoogleSignIn
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GIDSignIn.sharedInstance().clientID = "963125769246-7a3qn8lcb8r7li2f14ednrt45ot2f6fv.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
        if user == nil{
            print(error?.localizedDescription ?? "Error")
        }else{
            print("user email \(user.profile.email ?? "Error")")
            let firestoreDataBase = Firestore.firestore()
            firestoreDataBase.collection("Usernames").whereField("email", isEqualTo: user.profile.email!).getDocuments(){(querySnapshot, err) in
                if querySnapshot?.isEmpty == true
                {
                    print("girdim1")
                    Auth.auth().createUser(withEmail: user.profile.email, password: user.profile.email) { (authData, error) in
                        if error != nil {
                            print(error?.localizedDescription ?? "Error")
                            print("girdim2")
                        }
                        else
                        {
                            let userDictinoary = ["email" : user.profile.email!, "username": user.profile.name!, "password" : user.profile.email!, "Posted" : 0] as [String : Any]
                            
                            let userNameDic = ["usernames" : user.profile.name!] as [String : Any]
                            
                            firestoreDataBase.collection("AllUserNames").addDocument(data: userNameDic)
                            firestoreDataBase.collection("Usernames").document(Auth.auth().currentUser!.email!).setData(userDictinoary) { (error) in
                                if error != nil {
                                    print(error?.localizedDescription ?? "Errore")
                                    
                                }
                                else{
                                    print("girdim3")
                                    commentSing.sharedCommentInfo.segue = true 
                                }
                            }
                        }
                    }
                }
                else{
                    print("girdim4")
                    commentSing.sharedCommentInfo.segue = true
                }
            }
            

            
        }
            
      }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }


}

