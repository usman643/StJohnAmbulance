//
//  ENTALDAPICommonModel.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import Foundation

struct ENTALDAPICommonModel : Codable {
    var cmd : String?
    var http_response: Int?
    var code: Int?
    var success: Bool?
    var message: String?
    var data: ENTALDAPIData?
    var rawApiData: [String : Any]?
    
    //for internal use only
    var selectedData: Any?
    
    enum CodingKeys: String, CodingKey {
        case cmd, http_response, code, success, message, data
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.cmd = try container.decodeIfPresent(String.self, forKey: .cmd)
            self.http_response = try container.decodeIfPresent(Int.self, forKey: .http_response)
            self.code = try container.decodeIfPresent(Int.self, forKey: .code)
            self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
            self.message = try container.decodeIfPresent(String.self, forKey: .message)
            self.data = try container.decodeIfPresent(ENTALDAPIData.self, forKey: .data)
            self.rawApiData = try container.decodeIfPresent([String:Any].self, forKey: .data)
        }catch(let error){
            print("Data parsing error because \(error.localizedDescription)")
        }
    }
}


struct ENTALDAPIData : Codable {
    
    //MARK: - Config Model
    var configs : ENTALDConfigModel?
    var location: ENTALDLocationConfigModel?
    var tutorials_list: [ENTALDTutorialsModel]?
    var interested_categories: [String]?
    //############################################################
    
    //MARK: - Countries Model
    var countries : [ENTALDCountryModel]?
    var countries_version : String?
    //##############################################################
    
    //MARK: - OnBoarding Model
    var onboarding_sections : [ENTALDOnBoardingSectionModel]?
}



struct JSONCodingKeys: CodingKey {
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

extension Encodable {
    
    func jsonData() throws -> Data{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dataEncodingStrategy = .deferredToData
        return try encoder.encode(self)
    }
    
}


extension KeyedDecodingContainer {

    func decode(_ type: Dictionary<String, Any>.Type, forKey key: K) throws -> Dictionary<String, Any> {
        let container = try self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }

    func decodeIfPresent(_ type: Dictionary<String, Any>.Type, forKey key: K) throws -> Dictionary<String, Any>? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }

    func decode(_ type: Array<Any>.Type, forKey key: K) throws -> Array<Any> {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }

    func decodeIfPresent(_ type: Array<Any>.Type, forKey key: K) throws -> Array<Any>? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }

    func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()

        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode(Array<Any>.self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {

    mutating func decode(_ type: Array<Any>.Type) throws -> Array<Any> {
        var array: [Any] = []
        while isAtEnd == false {
            // See if the current value in the JSON array is `null` first and prevent infite recursion with nested arrays.
            if try decodeNil() {
                continue
            } else if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode(Array<Any>.self) {
                array.append(nestedArray)
            }
        }
        return array
    }

    mutating func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {

        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}
