//
//
//  CityBik_es
//  Copyright (c) 2019 Matteo Battistini
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

struct BikeNetworks: Decodable {
    
    enum BikeNetworksCodingKey: String, CodingKey {
        case companies = "networks"
    }
    
    let companies: [CompanyInfo]
    
    public init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: BikeNetworksCodingKey.self)
        self.companies = try container.decode([CompanyInfo].self, forKey: .companies)
    }
}

struct CompanyInfo: Decodable {
    /*
     all Optional to handle the fild filtering
    */
    let company: [String]?
    let href: String?
    let id: String?
    let location: CompanyLocation?
    let name: String?
}

struct CompanyLocation: Decodable {
    let city: String
    let country: String
    let latitude: Float64
    let longitude: Float64
}

enum RootNetworkCodingKey: CodingKey {
    case network
}

struct Company: Decodable {
    
    enum CompanyCodingKey: CodingKey {
        case company
        case href
        case id
        case location
        case name
        case stations
    }
    
    let info: CompanyInfo
    let stations: [BikeStation]
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: RootNetworkCodingKey.self)
        let network   = try container.nestedContainer(keyedBy: CompanyCodingKey.self, forKey: .network)
        
        let company   = try network.decodeIfPresent([String].self, forKey: .company)
        let href      = try network.decodeIfPresent(String.self, forKey: .href)
        let id        = try network.decodeIfPresent(String.self, forKey: .id)
        let location  = try network.decodeIfPresent(CompanyLocation.self, forKey: .location)
        let name      = try network.decodeIfPresent(String.self, forKey: .name)
        
        self.info     = CompanyInfo(company: company, href: href, id: id, location: location, name: name)
        self.stations = try network.decodeIfPresent([BikeStation].self, forKey: .stations)!
    }
}

struct BikeStation: Decodable {
    
    let emptySlots: UInt64?
    let freeBikes: UInt64?
    let id: String?
    
    //TODO: separated object Coordinate {lat, lon}
    let latitude: Float64
    let longitude: Float64
    
    let name: String?
    // TODO: convert to Date
    let timestamp: String?

    //TODO: Parse extra as Dictionary [String: Any]
    //let extra: Data?
    
    
}
