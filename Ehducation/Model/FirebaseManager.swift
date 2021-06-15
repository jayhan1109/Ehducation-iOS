//
//  FirebaseManager.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-15.
//

import Foundation
import Firebase

class FirebaseManager{
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    var user: User?
    
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
        
        print("create")
        print(self.user)
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
        
        print("load")
        print(self.user)
    }
}
