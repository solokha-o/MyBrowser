//
//  LoadRequestModel.swift
//  MyBrowser
//
//  Created by Oleksandr Solokha on 23.06.2020.
//  Copyright © 2020 Oleksandr Solokha. All rights reserved.
//

import Foundation
import WebKit

struct LoadRequestModel {
    // function to load link and get request
    func loadLink(link: String, webView: WKWebView) {
        guard let url = URL(string: link) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
