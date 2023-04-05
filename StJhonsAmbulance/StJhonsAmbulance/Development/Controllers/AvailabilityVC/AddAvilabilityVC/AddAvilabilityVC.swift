//
//  AddAvilabilityVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 06/04/2023.
//

import UIKit

class AddAvilabilityVC: ENTALDBaseViewController {

    let days = ProcessUtils.shared.days
    var selectedDays : [Int] = []
    
    
    @IBOutlet var lblAllTitle: [UILabel]!
    @IBOutlet weak var txtTitle: ACFloatingTextfield!
    @IBOutlet weak var txtEffectiveFrom: ACFloatingTextfield!
    @IBOutlet weak var txtEffectiveTo: ACFloatingTextfield!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnSelectDay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
       
    }
    
    func registerCell(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LanguageCVC", bundle: nil), forCellWithReuseIdentifier: "LanguageCVC")
    }
    
    func decorateUI(){
        
       for label in lblAllTitle{
           label.font = UIFont.BoldFont(14)
           label.textColor = UIColor.themePrimaryWhite
        }
                
        txtTitle.font = UIFont.SemiBoldFont(14)
        txtEffectiveFrom.font = UIFont.SemiBoldFont(14)
        txtEffectiveTo.font = UIFont.SemiBoldFont(14)
        txtTitle.textColor = UIColor.themePrimaryWhite
        txtEffectiveFrom.textColor = UIColor.themePrimaryWhite
        txtEffectiveTo.textColor = UIColor.themePrimaryWhite
        txtTitle.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEffectiveFrom.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEffectiveTo.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtTitle.layer.borderWidth = 1
        txtEffectiveFrom.layer.borderWidth = 1
        txtEffectiveTo.layer.borderWidth = 1
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnSubmit.titleLabel?.font = UIFont.BoldFont(14)
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectDay.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectDay.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
    }

    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        if (self.txtTitle.text != ""){
            self.txtTitle.errorText = "Please Enter Title"
            return
        }
        if (self.txtEffectiveFrom.text != ""){
            self.txtEffectiveFrom.errorText = "Please Enter from title"
            return
        }
        if (self.txtEffectiveTo.text != ""){
            self.txtEffectiveTo.errorText = "Please Enter Effective to date"
            return
        }
        
    }
    
    
    @IBAction func btnSelectDay(_ sender: Any) {
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.days, dataObj: self.days) { params, controller in
            
            if let data = params as? Int{
                
                let day = ProcessUtils.shared.getDay(code: data)
                self.btnSelectDay.setTitle(day, for: .normal)
                if (!self.selectedDays.contains(data)){
                    self.selectedDays.append(data)
                }
                
            }
                self.collectionView.reloadData()
                
            }
        }
        
        
        
        
    
    
//    func getOtherLanguage()->String?{
//        var language = ""
//        for lang in self.languageData {
//            if let languageName = lang.value{
//                if (lang.value == self.languageData.last?.value ) {
//
//                    language += "\(languageName)"
//                }else{
//                    language += "\(languageName), "
//                }
//            }
//        }
//        return language
//    }

    
}


extension AddAvilabilityVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCVC", for: indexPath) as! LanguageCVC
        
        cell.lblTitle.text = ProcessUtils.shared.getDay(code: selectedDays[indexPath.row])
        
        
        cell.isFromAvailbility = true
        cell.index =  indexPath.row
//        cell.dayDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSizeMake(130, 40)
    }
    
    
}
