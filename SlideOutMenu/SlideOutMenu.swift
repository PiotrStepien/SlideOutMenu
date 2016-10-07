//
//  SlideOutMenu.swift
//  SlideOutMenu
//
//  Created by Piotr Stepien on 06.10.2016.
//  Copyright © 2016 Piotr Stepien. All rights reserved.
//

import UIKit

class SlideOutMenu: UIViewController {
    
    //--------------------------------------------------------------------------------
    // Views using as Slide Out Menu
    //--------------------------------------------------------------------------------
    
    fileprivate lazy var slideOutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    fileprivate var blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        return table
    }()
    
    //--------------------------------------------------------------------------------
    // Variables
    //--------------------------------------------------------------------------------
    
    fileprivate var slideOutViewWidthConstraint: NSLayoutConstraint!
    fileprivate var keyWindow: UIWindow?
    fileprivate var swipeRightGestRecognizer = UISwipeGestureRecognizer()
    fileprivate var swipeLeftGestRecognizer = UISwipeGestureRecognizer()
    fileprivate var cellID = "cellMenu"
    
    //--------------------------------------------------------------------------------
    // SET TITLES FOR ROWS IN SLIDE MENU IN ARRAY BELLOW
    //--------------------------------------------------------------------------------
    
    var menuTitles = ["One", "Two", "Three", "Four", "Five", "Six"]
    
    //--------------------------------------------------------------------------------
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initSlideOutView()
        initTableViewForSlieOutMenu()
    }
    
    //--------------------------------------------------------------------------------
    // Initiation methods for slide out menu
    //--------------------------------------------------------------------------------
    
    fileprivate func initSlideOutView(){
        if let keyWindow = UIApplication.shared.keyWindow {
            setBlackView(window: keyWindow)
            keyWindow.addSubview(slideOutView)
            slideOutView.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
            slideOutView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
            slideOutViewWidthConstraint = slideOutView.widthAnchor.constraint(equalToConstant: 0)
            slideOutViewWidthConstraint.isActive = true
            self.keyWindow = keyWindow
            setSwipeGestRecognizers()
        }
        
    }
    
    fileprivate func initTableViewForSlieOutMenu(){
        slideOutView.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: slideOutView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: slideOutView.centerYAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: slideOutView.heightAnchor, multiplier: 0.5).isActive = true
        tableView.leftAnchor.constraint(equalTo: slideOutView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: slideOutView.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    //--------------------------------------------------------------------------------
    // Black subview showing while slide in Slide Out Menu
    //--------------------------------------------------------------------------------
    
    fileprivate func setBlackView(window: UIWindow){
        window.addSubview(blackView)
        blackView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        blackView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
        blackView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        blackView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
    }
    
    //--------------------------------------------------------------------------------
    // Gestrecognizers
    //--------------------------------------------------------------------------------
    
    fileprivate func setSwipeGestRecognizers(){
        guard let keyWindow = self.keyWindow else { print("no Key Window")
            return
        }
        swipeRightGestRecognizer.addTarget(self, action: #selector(showSlideOutMenu))
        swipeRightGestRecognizer.direction = .right
        keyWindow.addGestureRecognizer(swipeRightGestRecognizer)
        
        swipeLeftGestRecognizer.addTarget(self, action: #selector(hideSlideOutMenu))
        swipeLeftGestRecognizer.direction = .left
        keyWindow.addGestureRecognizer(swipeLeftGestRecognizer)
    }
    
    //--------------------------------------------------------------------------------
    // Slide in and slide out mechanism
    //--------------------------------------------------------------------------------
    
    @objc fileprivate func showSlideOutMenu(sender: UISwipeGestureRecognizer){
        if sender.direction == .right {
            slideInSlideOutMenu()
        }
    }
    
    @objc fileprivate func hideSlideOutMenu(sender: UISwipeGestureRecognizer){
        if sender.direction == .left {
            slideOutSlideOutMenu()
        }
    }
    
    fileprivate func slideInSlideOutMenu(){
        guard let keyWindow = self.keyWindow else { print("no Key Window")
            return
        }
        slideOutViewWidthConstraint.constant = 220
        blackView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            keyWindow.layoutIfNeeded()
            self.blackView.alpha = 0.5
        }) { (succes: Bool) in
            
            /* Do something if needed */
        }
    }
    
    fileprivate func slideOutSlideOutMenu(){
        guard let keyWindow = self.keyWindow else { print("no Key Window")
            return
        }
        slideOutViewWidthConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            keyWindow.layoutIfNeeded()
            self.blackView.alpha = 0
        }) { (success: Bool) in
            self.blackView.isHidden = true
        }
    }
}


extension SlideOutMenu: UITableViewDelegate, UITableViewDataSource {
    
    //--------------------------------------------------------------------------------
    // Slide in and slide out mechanism
    //--------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = menuTitles[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /* Do some action for menu cell */
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}







