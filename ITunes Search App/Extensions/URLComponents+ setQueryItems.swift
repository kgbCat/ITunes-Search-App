//
//  URLComponents+ setQueryItems.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/13/22.
//

import Foundation

extension URLComponents {

    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
