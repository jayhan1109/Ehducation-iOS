//
//  FirebaseManager.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-15.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class FirebaseManager{
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    var user: User?
    var questions: [Post] = []
    
    private init(){}
    
    func createUser(with user: User?){
        self.user = user
        
        // Add a new document with a generated id.
        let userDoc = K.FStore.User.self
        var ref: DocumentReference? = nil
        
        if let user = user {
            ref = db.collection(userDoc.collectionName).addDocument(data: [
                userDoc.userIdField: user.id,
                userDoc.usernameField : user.username,
                userDoc.emailField : user.email,
                userDoc.expField : user.exp,
                userDoc.answeredField : user.answered,
                userDoc.starredField : user.answered
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }
    
    func loadUser(email: String){
        
        let userDoc = K.FStore.User.self
        
        db.collection(userDoc.collectionName).whereField(userDoc.emailField, isEqualTo: email)
            .addSnapshotListener { documentSnapshot, err in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let data = documentSnapshot!.documents[0].data()
                    
                    if let id = data[userDoc.userIdField] as? String, let exp = data[userDoc.expField] as? Int, let answered = data[userDoc.answeredField] as? Int, let starred = data[userDoc.starredField] as? Int {
                        
                        let user = User(id: id, email: email, exp: exp, answered: answered, starred: starred)
                        
                        self.user = user
                    }
                }
            }
    }
    
    func uploadImage(images: [Data], timestamp: TimeInterval) -> String{
        //        let storageRef = Storage.storage().reference()
        //
        //        for data in images{
        //            // Create a reference to the file you want to upload
        //            let riversRef = storageRef.child("\(user?.id)/")
        //
        //            // Upload the file to the path "images/rivers.jpg"
        //            let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
        //              guard let metadata = metadata else {
        //                // Uh-oh, an error occurred!
        //                return
        //              }
        //              // Metadata contains file metadata such as size, content-type.
        //              let size = metadata.size
        //              // You can also access to download URL after upload.
        //              riversRef.downloadURL { (url, error) in
        //                guard let downloadURL = url else {
        //                  // Uh-oh, an error occurred!
        //                  return
        //                }
        //              }
        //            }
        //        }
        
        return ""
    }
    
    func generateAlert(title: String, isTextField: Bool) -> UIAlertController{
        var alert: UIAlertController?
        
        if isTextField {
            alert = UIAlertController(title: "Alert", message: "\(title) is empty", preferredStyle: UIAlertController.Style.alert)
        } else{
            alert = UIAlertController(title: "Alert", message: "\(title) is not selected", preferredStyle: UIAlertController.Style.alert)
        }
        
        
        // add an action (button)
        alert!.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        return alert!
    }
}
