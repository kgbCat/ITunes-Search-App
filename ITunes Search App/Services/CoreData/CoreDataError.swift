//
//  CoreDataError.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/14/22.
//

import Foundation

enum CoreDataError: String{
    case couldntSave = "Unable to save user in Data base"
    case couldntFetch = "Unable to fetch user from Data base"
    case couldFetchWithEmail = "Unable to fetch user from Data base via email"

}
