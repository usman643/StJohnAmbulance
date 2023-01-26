//
//  MessageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class MessageVC: UIViewController {

    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnGroup: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var emailView: UIView!

    @IBOutlet weak var lblInbox: UILabel!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "MessageTVC", bundle: nil), forCellReuseIdentifier: "MessageTVC")
        decorateUI()
        
    }

    func decorateUI(){
        
        btnBack.titleLabel?.font = UIFont.RegularFont(14)
        btnHome.titleLabel?.font = UIFont.RegularFont(14)
        btnGroup.titleLabel?.font = UIFont.RegularFont(14)
        btnCall.titleLabel?.font = UIFont.RegularFont(14)
        btnText.titleLabel?.font = UIFont.RegularFont(14)
        btnEmail.titleLabel?.font = UIFont.RegularFont(14)
        
        btnBack.titleLabel?.textColor = UIColor.textWhiteColor
        btnHome.titleLabel?.textColor = UIColor.textWhiteColor
        btnGroup.titleLabel?.textColor = UIColor.textWhiteColor
        btnCall.titleLabel?.textColor = UIColor.textWhiteColor
        btnText.titleLabel?.textColor = UIColor.textWhiteColor
        btnEmail.titleLabel?.textColor = UIColor.textWhiteColor
        
        groupView.layer.cornerRadius = 8
        callView.layer.cornerRadius = 8
        textView.layer.cornerRadius = 8
        emailView.layer.cornerRadius = 8
        
        groupView.backgroundColor = UIColor.themePrimaryColor
        callView.backgroundColor = UIColor.themePrimaryColor
        textView.backgroundColor = UIColor.themePrimaryColor
        emailView.backgroundColor = UIColor.themePrimaryColor
        
        lblInbox.font = UIFont.BoldFont(16)
        lblInbox.textColor = UIColor.themePrimaryColor
    }


    @IBAction func backTapped(_ sender: Any) {
    }
    
    
    @IBAction func homeTapped(_ sender: Any) {
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
    }
    
    @IBAction func callTapped(_ sender: Any) {
    }
    
    @IBAction func textTapped(_ sender: Any) {
    }
    
    @IBAction func emailTapped(_ sender: Any) {
    }
    
}


extension MessageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "MessageTVC", for: indexPath) as! MessageTVC
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
