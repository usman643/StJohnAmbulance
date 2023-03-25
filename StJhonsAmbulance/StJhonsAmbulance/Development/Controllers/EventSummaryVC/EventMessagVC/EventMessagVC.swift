//
//  EventMessagVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventMessagVC: ENTALDBaseViewController {

    var eventId :String?
    
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSectionHeading: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
    }
    
    func registerCell(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "EventMessageTVC", bundle: nil), forCellReuseIdentifier: "EventMessageTVC")
    }

    func decorateUI(){
        
        lbltitle.font = UIFont.BoldFont(22)
        lblStatus.font = UIFont.BoldFont(13)
        lblSectionHeading.font = UIFont.BoldFont(14)
        lblStatus.textColor = UIColor.themePrimaryWhite
        lblSectionHeading.textColor = UIColor.themePrimaryWhite
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnMessage.layer.cornerRadius = btnMessage.frame.size.height/2
        btnStatus.layer.cornerRadius = 5
        for label in lblTableHeadings{
            label.textColor = UIColor.themePrimaryWhite
            label.font = UIFont.BoldFont(11)
        }
        
    }


    @IBAction func submitTapped(_ sender: Any) {
        
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
    }
}

extension EventMessagVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventMessageTVC", for: indexPath) as! EventMessageTVC
        
        return cell
    }
}
