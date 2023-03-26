//
//  EventAuditVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventAuditVC:ENTALDBaseViewController {
    
    var eventData : CurrentEventsModel?
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblSectionHeading: UILabel!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
    }
    
    func registerCell(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "EventAuditTVC", bundle: nil), forCellReuseIdentifier: "EventAuditTVC")
    }

    func decorateUI(){
        
        lbltitle.font = UIFont.BoldFont(22)
        lblSectionHeading.font = UIFont.BoldFont(14)
        lblSectionHeading.textColor = UIColor.themePrimaryWhite

        for label in lblTableHeadings{
            label.textColor = UIColor.themePrimaryWhite
            label.font = UIFont.BoldFont(11)
        }
        
    }


    @IBAction func submitTapped(_ sender: Any) {
        
    }
    
    @IBAction func StatusTapped(_ sender: Any) {
        
    }
}

extension EventAuditVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventAuditTVC", for: indexPath) as! EventAuditTVC
        
        return cell
    }
    
    
    
}
