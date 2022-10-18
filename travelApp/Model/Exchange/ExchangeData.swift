//
//  Currency.swift
//  travelApp
//
//  Created by Loranne Joncheray on 13/09/2022.
//

import Foundation

struct ExchangeData: Decodable {
    let date: String
    let rates : [String: Double]
}
  



/*enum CodingKeys: CodingKey {
        case date
        case rates
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let date = try container.decode(String.self, forKey: .date)
        
        var dateOfToday: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: dateNow)
        }
        
        let dateNow = Date()
        
        guard dateOfToday == date
        else {
            print("Error date download")
            throw ExchangeDataError.invalidDate
        }
        self.date = date
        self.rates = try container.decode([String : Double].self, forKey: .rates)
    }
}
*/
