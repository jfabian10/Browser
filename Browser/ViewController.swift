//
//  ViewController.swift
//  Browser
//
//  Created by CS3714 on 9/19/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIWebViewDelegate, UITextFieldDelegate {
    
    
    let backButtonBlueImage     = UIImage(named: "BackBlueArrow")
    
    let backButtonGrayImage     = UIImage(named: "BackGrayArrow")
    
    let forwardButtonBlueImage  = UIImage(named: "ForwardBlueArrow")
    
    let forwardButtonGrayImage  = UIImage(named: "ForwardGrayArrow")
    
    @IBOutlet var urlTextField: UITextField!
    
    @IBOutlet var backButton: UIButton!

    
    @IBAction func backButtonTapped(_ sender: UIButton) {
       
        print("Back button works!")
         webView.goBack()
    }
    
  
    @IBOutlet var forwardButton: UIButton!
    
    
    @IBOutlet var webView: UIWebView!
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        
        print("forward tapped!")
        webView.goForward()
    }
    
    
    func setBackForwardButtons() {
        
        
        
        // Display the back button in blue color if a previous web page exists.
        
        // Otherwise, display it in gray color.
        
        
        
        if webView.canGoBack {
            
            backButton.setImage(backButtonBlueImage, for: UIControlState())
            
        } else {
            
            backButton.setImage(backButtonGrayImage, for: UIControlState())
            
        }
        
        
        if webView.canGoForward {
            
            forwardButton.setImage(forwardButtonBlueImage, for: UIControlState())
            
        } else {
            
            forwardButton.setImage(forwardButtonGrayImage, for: UIControlState())
            
        }
        
    }
    //method when user taps Go or hits return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //deactivate text field and remove keyboard
        textField.resignFirstResponder()
        
        //assign URL text entered by user into a constant 
        let enteredURL = textField.text
        
        var url:URL?
        
        if enteredURL!.hasPrefix("http://"){
            
            //create instance of url structure and store it in local var
            url = URL(string: enteredURL!)
            
        }
        else {
            url = URL(string: "http://" + enteredURL!)
        }
        
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        return true
        
    }
    
    
    ///at the very beg
    override func viewDidLoad() {
        
        //URL is a swift [structure] that can contain location of
        //resource on a remote server, path of a local files on disk
        //create an instance of the URL stucture, initialize it
        //with nba.com/heat an store its ID to local const
        let url = URL(string: "http://www.nba.com/heat")
        
       ///create instance of URLRequest Structure and 
        //store its value in local const
        let request = URLRequest(url: url!)
        
        //ask webView to load page
        webView.loadRequest(request)
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*
     
     ------------------------------------------
     
     MARK: - UIWebViewDelegate Protocol Methods
     
     ------------------------------------------
     
     */
    
    
    // Starting to load the web page. Show the animated activity indicator in the status bar
    // to indicate to the user that the UIWebVIew object is busy loading the web page.
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // Finished loading the web page. Hide the activity indicator in the status bar.
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        // Display the URL of the loaded web page in the URL text field
        
        urlTextField.text = self.webView.stringByEvaluatingJavaScript(from: "window.location.href")
        
        // Call this function to set the colors of the back and forward buttons
        
        setBackForwardButtons()
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        /*
         
         Ignore this error if the page is instantly redirected via JavaScript or in another way.
         
         NSURLErrorCancelled is returned when an asynchronous load is cancelled, which happens
         
         when the page is instantly redirected via JavaScript or in another way.
         
         */
        
        
        
        if (error as NSError).code == NSURLErrorCancelled  {
            
            return
            
        }

        
        setBackForwardButtons()

        // An error occurred during the web page load. Hide the activity indicator in the status bar.
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        // Create the error message in HTML as a character string and store it into the local constant errorString
        
        let errorString = "<html><font size=+2 color='red'><p>An error occurred: <br />Dont' be silly, type in a valid URL :) <br />- In the meantime you can call your mom<br />- Talk to your  neighbor<br />- Or even do your homework!</p></font></html>" + error.localizedDescription
        
        
        
        // Display the error message within the UIWebView object
        
        self.webView.loadHTMLString(errorString, baseURL: nil)
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    


}

