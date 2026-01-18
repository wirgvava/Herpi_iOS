

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
  }
}

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    return String(format: key.localized(using: table), arguments: args)
  }
}

