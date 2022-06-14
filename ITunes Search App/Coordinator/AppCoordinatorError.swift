//
//  AppCoordinatorError.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/14/22.
//

import Foundation

enum AppCoordinatorError: String {
    case loginSceneError = "Unable to Instantiate Login View Controller"
    case registerSceneError = "Unable to Instantiate Register View Controller"
    case albumSearchSceneError = "Unable to Instantiate Album View Controller"
    case trackSceneError = "Unable to Instantiate Track View Controller"
}
