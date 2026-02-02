

import Foundation
import HerpiFoundation


enum L {

  enum MainPage {

    enum Header {
      /// Pick Region Manually
       static var pickLocation: String {
          return L.tr("Localizable", "MainPage.Header.PickLocation")
      }
      /// Region
       static var region: String {
          return L.tr("Localizable", "MainPage.Header.Region")
      }
    }

    enum NearbyReptiles {
      /// Species you encounter based on your location
       static var description: String {
          return L.tr("Localizable", "MainPage.NearbyReptiles.Description")
      }
      /// No species were found in this area
       static var emptyList: String {
          return L.tr("Localizable", "MainPage.NearbyReptiles.EmptyList")
      }
      /// Near You
       static var header: String {
          return L.tr("Localizable", "MainPage.NearbyReptiles.Header")
      }
    }

    enum ReptilesList {
      /// Every officially registered specie in the country
       static var headerDescription: String {
          return L.tr("Localizable", "MainPage.ReptilesList.HeaderDescription")
      }
      /// Read More
       static var readMoreBtn: String {
          return L.tr("Localizable", "MainPage.ReptilesList.ReadMoreBtn")
      }
    }
  }

  enum Menu {
    /// Contact
     static var contact: String {
        return L.tr("Localizable", "Menu.Contact")
    }
    /// Frequently Asked \nQuestions
     static var faq: String {
        return L.tr("Localizable", "Menu.FAQ")
    }
    /// Home
     static var main: String {
        return L.tr("Localizable", "Menu.Main")
    }
    /// Team
     static var team: String {
        return L.tr("Localizable", "Menu.Team")
    }
  }

  enum SearchBar {
    /// Search here...
     static var placeholder: String {
        return L.tr("Localizable", "SearchBar.Placeholder")
    }
  }

  enum VenomType {
    /// Mild Venom
     static var midVenomous: String {
        return L.tr("Localizable", "VenomType.MidVenomous")
    }
    /// Harmless
     static var noVenomous: String {
        return L.tr("Localizable", "VenomType.NoVenomous")
    }
    /// Venomous
     static var venomous: String {
        return L.tr("Localizable", "VenomType.Venomous")
    }
  }
}

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    return String(format: key.localized(using: table), arguments: args)
  }
}

