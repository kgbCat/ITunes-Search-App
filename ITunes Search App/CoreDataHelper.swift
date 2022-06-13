//
//  CoreDataHelper.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class CoreDataHelper {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func createUser(name: String,
                    lastName: String,
                    email: String,
                    password: String,
                    cellphone: String,
                    age: String) {
        let newUser = User(context: context)
        newUser.name = name
        newUser.lastName = lastName
        newUser.age = age
        newUser.email = email
        newUser.password = password
        newUser.cellphone =  cellphone

        do {
            try context.save()
        } catch {
            // TODO: handle error
        }
    }

    func getUser(email: String, password:String) -> User? {
        var returnedUser: User?
        do {
            let users = try context.fetch(User.fetchRequest())
            users.forEach { [weak self] user in
                guard self != nil else { return }
                if user.email == email && user.password == password {
                    returnedUser = user
                } else {
                    returnedUser = nil
                }
            }
        } catch {
            // TODO: handle error
        }
        return returnedUser
    }
}
