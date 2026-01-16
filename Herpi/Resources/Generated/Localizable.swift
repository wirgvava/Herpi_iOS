

import Foundation
import HerpiFoundation


enum L {

  enum Main {
    /// Test text
     static var test: String {
        return L.tr("Localizable", "Main.Test")
    }
  }
}

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    return String(format: key.localized(using: table), arguments: args)
  }
}

