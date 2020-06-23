//
//  ViewController.swift
//  MyBrowser
//
//  Created by Oleksandr Solokha on 23.06.2020.
//  Copyright © 2020 Oleksandr Solokha. All rights reserved.
//

import UIKit
import WebKit


class MyBrowserViewController: UIViewController {
    @IBOutlet weak var enterLinkTextField: UITextField! {
        didSet {
            enterLinkTextField.text = "https://"
        }
    }
    @IBOutlet weak var loadLinkButtonOutlet: UIButton!
    @IBOutlet weak var webView: WKWebView!
    // create instance LoadRequestModel to get Request from url
    let loadRequest = LoadRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call setup and configure function
        desingSetup()
    }
    //configure button action
    @IBAction func loadLinkButtonAction(_ sender: UIButton) {
        guard let link = enterLinkTextField.text else { return }
        loadRequest.loadLink(link: link, webView: webView)
    }
    //configure desing view
    func desingSetup() {
        let arrow = UIImage(systemName: "arrow.right.circle")
        loadLinkButtonOutlet.setImage(arrow, for: .normal)
        navigationItem.title = "MyBrowser"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

