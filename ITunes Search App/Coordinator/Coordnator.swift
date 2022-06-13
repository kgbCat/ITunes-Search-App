//
//  Coordnator.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//
 
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? {get set}
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
