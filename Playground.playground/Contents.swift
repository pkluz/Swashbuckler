import Foundation
@testable import Swashbuckler
import Result

let input = "isTranslucent false\n.feedViewController\n    backgroundColor #FF00CC\n    defaultFont 12pt \'Helvetica-Neue\'\n\n    #headerView\n        isTranslucent true\n        titleFont @defaultFont\n\n        #subheaderView\n            isOpaque true\n            subtitleFont @defaultFont\n"
let root = Swashbuckler.run(input: input).value!
root

let result = Resolver.leafs(for: root, keypath: [], current: [:])
result

let resolved = Resolver.resolve(value: root, keypath: [], globalNamespace: result)
print(resolved)
