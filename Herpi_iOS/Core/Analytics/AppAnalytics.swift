//
//  AppAnalytics.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 20.02.24.
//

import Foundation
import FirebaseAnalytics

class AppAnalytics {
    static func logEvents(with name: EventNames, paramName: EventParams?, paramData: Any?) {
        if paramName == nil {
            Analytics.logEvent(name.rawValue, parameters: nil)
        } else {
            Analytics.logEvent(name.rawValue, parameters: [paramName!.rawValue : paramData!])
        }
    }
    
    static func logEvents(with name: EventNames, parameters: [String : Any]?) {
        Analytics.logEvent(name.rawValue, parameters: parameters)
    }
   
    enum EventNames: String {
        case select_category
        case set_language
        case nearby_species_not_found
        case open_nearby_specie_details
        case open_in_offline_mode
        case open_details
        case open_faq
        case open_team
        case open_search
        case open_contact
        case click_team_email
        case click_team_social_link
        case click_chat
        case click_pick_location_manually
        case pick_location_manually
        case expand_distribution_map
        case share
    }
    
    enum EventParams: String {
        case category_id
        case language_code
        case reason
        case specie_id
        case member
        case network
    }
}
