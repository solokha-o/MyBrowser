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
    @IBOutlet weak var goBackButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var goForwardButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    // create instance LoadRequestModel to get Request from url
    let loadRequest = LoadRequestModel()
    // add progress view
    var progressView = UIProgressView()
    // create NSKeyValueObservation instance
    var estimatedProgressObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call setup and configure function
        designSetup()
        setupEstimatedProgressObserver()
        setToolBar()
    }
    // configure goBackButtonAction
    @IBAction func goBackButtonAction(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    //configure goForwardButtonAction
    @IBAction func goForwardButtonAction(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    //configure button action
    @IBAction func loadLinkButtonAction(_ sender: UIButton) {
        guard let link = enterLinkTextField.text else { return }
        loadRequest.loadLink(link: link, webView: webView)
    }
    //configure design view
    func designSetup() {
        let arrow = UIImage(systemName: "arrow.right.circle")
        loadLinkButtonOutlet.setImage(arrow, for: .normal)
        let chevronLeft = UIImage(systemName: "chevron.left")
        goBackButtonOutlet.image = chevronLeft
        let chevronRight = UIImage(systemName: "chevron.right")
        goForwardButtonOutlet.image = chevronRight
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = webView.title
        //configure progressView
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .red
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        progressView.frame = CGRect(x: 0, y: navigationBarBounds!.size.height - 2, width: navigationBarBounds!.size.width, height: 2)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        progressView.progress = Float(webView.estimatedProgress)
        navigationController?.navigationBar.addSubview(progressView)
    }
    //setup estimated progress observer
    func setupEstimatedProgressObserver() {
           estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
               self?.progressView.progress = Float(webView.estimatedProgress)
           }
       }
    //configure tool bar
    func setToolBar() {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([goBackButtonOutlet, space, goForwardButtonOutlet], animated: true)
    }
}

