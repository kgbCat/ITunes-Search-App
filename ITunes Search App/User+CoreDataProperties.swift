//
//  User+CoreDataProperties.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var lastName: String
    @NSManaged public var age: String
    @NSManaged public var email: String
    @NSManaged public var password: String
    @NSManaged public var cellphone: String

}

extension User : Identifiable {

}
