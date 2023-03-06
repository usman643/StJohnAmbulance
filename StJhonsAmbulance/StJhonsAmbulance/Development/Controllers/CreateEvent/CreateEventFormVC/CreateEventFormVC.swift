//
//  CreateEventFormVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 3/6/23.
//

import UIKit

class CreateEventFormVC: ENTALDBaseViewController {
    @IBOutlet weak var segmentsCOntroll: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func onChangeSegment(_ sender: Any) {
        
        if segmentsCOntroll.selectedSegmentIndex == 0 {
            let vc = GeneralInfoFormVC.loadFromNib()
            self.navigationController?.present(vc, animated: true)
        }else {
            let vc = EventDetailInfoFormVC.loadFromNib()
            self.navigationController?.present(vc, animated: true)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
