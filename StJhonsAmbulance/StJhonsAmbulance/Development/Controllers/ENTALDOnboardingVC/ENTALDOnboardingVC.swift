//
//  ENTALDOnboardingVC.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import UIKit

class ENTALDOnboardingVC: ENTALDBaseViewController {
    
    var viewModel : ENTALDOnBoardingViewModel!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var skipBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleCallbackEvents()
        self.registerCell()
        self.designUI()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func registerCell(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let cellNames = ["ENTALDOnBoardingCVC"]
        self.collectionView.registerCollectionViewCell(cellNames)
    }
    
    
    private func designUI(){
        self.navigationController?.navigationBar.isHidden = true
        
        self.skipBtn.setTitleColor(.appBlack, for: .normal)
        self.skipBtn.setTitle("skip_btn_title".localized, for: .normal)
        self.skipBtn.titleLabel?.font = UIFont.ENTALDBoldFont(14.0)
        
        self.pageController.currentPageIndicatorTintColor = UIColor.hexString(hex: "725FDE")
        self.pageController.pageIndicatorTintColor = .appLightGray237
        self.pageController.backgroundColor = .clear
        
    }
    
    func handleCallbackEvents(){
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self else{return}
            self.pageController.numberOfPages = self.viewModel.tasks.count
            self.collectionView.reloadData()
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
    
    @IBAction func skipBtnAction(_ sender: Any) {
        self.viewModel.callbackToController?(self.viewModel.screenBaseModel, self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func continueBtnAction(_ sender: UIButton){
        let index = sender.tag
        let indexPath = IndexPath(item: index+1, section: 0)
        if index == viewModel.tasks.count - 1 {
            
        }else{
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    

}


extension ENTALDOnboardingVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowModel = viewModel.tasks[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ENTALDOnBoardingCVC.identifier, for: indexPath) as! ENTALDOnBoardingCVC
        cell.configure(ENTALDOnBoardingCVCViewModel(model: rowModel))
        cell.btnNext.tag = indexPath.item
        cell.btnNext.addTarget(self, action: #selector(continueBtnAction(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageController.currentPage = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
    }
    
}





//MARK: - ENTALDOnBoardingViewModel
final class ENTALDOnBoardingViewModel : ENTALDBaseViewModel {
    
    //callbacks to comunicate with controller
    var onUpdate : ENTALDVoidCompletion = {}
    var tasks : [ENTALDOnBoardingSectionModel] = []
    
    func viewDidLoad(){
        let model = ENTALDDummyDataUtils.shared.getOnBoardingModel()
        self.tasks = model?.data?.onboarding_sections ?? []
        
        self.onUpdate()
    }
    
    func numberOfItems()->Int{
        return tasks.count
    }
    
}
