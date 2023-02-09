//
//  EventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class EventDetailVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var contactBtnImg: UIImageView!
    @IBOutlet weak var btnContact: UIButton!
    
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var checkInBtnImg: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationDesc: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDetailDesc: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnCancel: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
    }

    func decorateUI(){
        
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
    }
    
    
    @IBAction func checkInTapped(_ sender: Any) {
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
    }
    
}
