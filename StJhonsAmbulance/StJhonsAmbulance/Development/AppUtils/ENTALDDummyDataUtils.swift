//
//  ENTALDDummyDataUtils.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 12/05/2022.
//

import Foundation

class ENTALDDummyDataUtils {
    
    static let shared : ENTALDDummyDataUtils = ENTALDDummyDataUtils()
    
    func getOnBoardingModel()->ENTALDAPICommonModel?{
        return ENTALDHelperUtils.loadJsonFile(fileName: "onBoardingJson")
    }
    
    
}
