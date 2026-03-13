//
//  AppAnalytics.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import Foundation
import FirebaseAnalytics

// MARK: - Analytics Event Protocol
protocol AnalyticsEvent {
    var name: String { get }
    var parameters: [String: Any]? { get }
}

// MARK: - App Analytics
enum AppAnalytics {
    static func log(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}

// MARK: - Events
extension AppAnalytics {
    
    // MARK: Category Events
    enum Category: AnalyticsEvent {
        case selected(id: String)
        
        var name: String { "select_category" }
        
        var parameters: [String: Any]? {
            switch self {
            case .selected(let id):
                return [Param.categoryId: id]
            }
        }
    }
    
    // MARK: Language Events
    enum Language: AnalyticsEvent {
        case changed(code: String)
        
        var name: String { "set_language" }
        
        var parameters: [String: Any]? {
            switch self {
            case .changed(let code):
                return [Param.languageCode: code]
            }
        }
    }
    
    // MARK: Nearby Species Events
    enum NearbySpecies: AnalyticsEvent {
        case notFound(reason: Reason)
        
        var name: String {
            switch self {
            case .notFound: return "nearby_species_not_found"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .notFound(let reason):
                return [Param.reason: reason.rawValue]
            }
        }
        
        enum Reason: String {
            case locationOff = "location_off"
            case nonInArea = "no species found in the area"
        }
    }
    
    // MARK: Navigation Events
    enum Navigation: AnalyticsEvent {
        case openedDetails(specieId: Int)
        case openedNearbySpecieDetails(specieId: Int)
        case openedFAQ
        case openedTeam
        case openedSearch
        case openedContact
        case openedInOfflineMode
        
        var name: String {
            switch self {
            case .openedDetails: return "open_details"
            case .openedNearbySpecieDetails: return "open_nearby_specie_details"
            case .openedFAQ: return "open_faq"
            case .openedTeam: return "open_team"
            case .openedSearch: return "open_search"
            case .openedContact: return "open_contact"
            case .openedInOfflineMode: return "open_in_offline_mode"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .openedDetails(let specieId), .openedNearbySpecieDetails(let specieId):
                return [Param.specieId: specieId]
            default:
                return nil
            }
        }
    }
    
    // MARK: Team Events
    enum Team: AnalyticsEvent {
        case clickedEmail(member: String)
        case clickedSocialLink(member: String, network: String)
        
        var name: String {
            switch self {
            case .clickedEmail: return "click_team_email"
            case .clickedSocialLink: return "click_team_social_link"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .clickedEmail(let member):
                return [Param.member: member]
            case .clickedSocialLink(let member, let network):
                return [Param.member: member, Param.network: network]
            }
        }
    }
    
    // MARK: Interaction Events
    enum Interaction: AnalyticsEvent {
        case clickedChat
        case clickedPickLocationManually
        case pickedLocationManually
        case expandedDistributionMap(specieId: Int)
        case shared(specieId: Int)
        
        var name: String {
            switch self {
            case .clickedChat: return "click_chat"
            case .clickedPickLocationManually: return "click_pick_location_manually"
            case .pickedLocationManually: return "pick_location_manually"
            case .expandedDistributionMap: return "expand_distribution_map"
            case .shared: return "share"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .expandedDistributionMap(let specieId), .shared(let specieId):
                return [Param.specieId: specieId]
            default:
                return nil
            }
        }
    }
}
// MARK: - Parameter Keys
private extension AppAnalytics {
    enum Param {
        static let categoryId = "category_id"
        static let languageCode = "language_code"
        static let reason = "reason"
        static let specieId = "specie_id"
        static let member = "member"
        static let network = "network"
    }
}
