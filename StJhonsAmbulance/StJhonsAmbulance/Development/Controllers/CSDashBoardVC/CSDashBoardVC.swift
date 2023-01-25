//
//  CSDashBoardVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/01/2023.
//

import UIKit
import SideMenu


class CSDashBoardVC: ENTALDBaseViewController,MenuControllerDelegate {
 
    var sideMenu: SideMenuVC?
    var menu: SideMenuNavigationController?
    var gridData : [DashBoardGridModel]?
    
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblGroupName: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var btnMainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnGroup: UIButton!
    @IBOutlet weak var lblLogoTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        collectionView.register(UINib(nibName: "CSDashBaordCVC", bundle: nil), forCellWithReuseIdentifier: "CSDashBaordCVC")
        decorateUI()
        setSideMenu()
        
        gridData = [
                    DashBoardGridModel(title: "Youth Camp", subTitle: "November 12th", bgColor: UIColor.darkBlueColor, icon: "ic_camp"),
                    DashBoardGridModel(title: "Messages", subTitle: "02", bgColor: UIColor.orangeRedColor, icon: "ic_message"),
                    DashBoardGridModel(title: "Volunteer", subTitle: "02", bgColor: UIColor.orangeColor, icon: "ic_communication"),
                    DashBoardGridModel(title: "Events", subTitle: "02", bgColor: UIColor.darkFrozeColor, icon: "ic_event"),
                    DashBoardGridModel(title: "Pending Shifts", subTitle: "02", bgColor: UIColor.lightBlueColor, icon: "ic_hour"),
                    DashBoardGridModel(title: "Pending Events", subTitle: "06", bgColor: UIColor.themePrimaryColor, icon: "ic_pendingEvent")
                ]
    }

    func setSideMenu(){
        
        self.sideMenu = SideMenuVC()
        if let list = sideMenu {
            
            list.delegate = self
            self.menu = SideMenuNavigationController(rootViewController: list)
            self.menu?.leftSide = false
            self.menu?.setNavigationBarHidden(true, animated: true)
            self.menu?.menuWidth = view.bounds.width * 0.8
            SideMenuManager.default.leftMenuNavigationController = menu
            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        }
    }
    
    func didSelectMenuItem(named: String) {
        
        if (named == "Home") {
            dismiss(animated: true)
//            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.navigationController?.pushViewController(vc , animated: true)
        }else if(named == "Logout"){
           
//            UserDefaultManger.shared.logout()
            self.navigationController?.popToRootViewController(animated: true)
            let loginvc = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController?.pushViewController(loginvc, animated: true)
            
        }else{
            
            dismiss(animated: true)
        }
    }

    func decorateUI(){
        self.btnMainView.backgroundColor = UIColor.themePrimaryColor
        self.btnMainView.layer.cornerRadius = 8
        lblLogoTitle.textColor = UIColor.themePrimaryColor
    }

    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    
}

extension CSDashBoardVC : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CSDashBaordCVC", for: indexPath) as! CSDashBaordCVC
        cell.lblTitle.text = gridData?[indexPath.item].title
        cell.lblCount.text = gridData?[indexPath.item].subTitle
        cell.imgView.image = UIImage(named: gridData?[indexPath.item].icon ?? "")
        cell.mainView.backgroundColor = gridData?[indexPath.item].bgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         let cellWidth = (UIScreen.main.bounds.size.width - 24)/2
        
        return CGSizeMake(cellWidth, 150)
    
    }
    
    
    
}


//
//    <color name="teal_200">#FF03DAC5</color>
//    <color name="teal_700">#FF018786</color>
//
//
//    <color name="colorLightRed">#E2364B</color>
//    <color name="colorRed">#D9011A</color>
//    <color name="colorScheduleEr">#DA542D</color>
//    <color name="colorScheduleErBackground">#FDDDD4</color>
//    <color name="colorScheduleNormal">#188A5C</color>
//    <color name="colorScheduleNormalBackground">#CEFEEB</color>
//
//
//
//    <color name="colorBlack">#000000</color>
//    <color name="colorThemeBlack">#000000</color>
//    <color name="colorThemeBlack1">#151515</color>

//    <color name="colorTransparent">#80000000</color>
