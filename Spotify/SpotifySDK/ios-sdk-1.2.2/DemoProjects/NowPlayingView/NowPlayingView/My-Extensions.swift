import Foundation

extension String {
    func encodeStringAsUrlParameter(_ value: String) -> String {
        let escapedString = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return escapedString!
    }
}

extension Dictionary {

    func urlParametersRepresentation() -> String {
        // Add the necessary parameters
        var pairs = [String]()
        for (key, value) in self {
            let keyString = key as! String
            let valueString = value as! String
            let encodedKey = keyString.encodeStringAsUrlParameter(key as! String)
            let encodedValue = valueString.encodeStringAsUrlParameter(value as! String)
            let encoded = String(format: "%@=%@", encodedKey, encodedValue);
            pairs.append(encoded)
        }

        return pairs.joined(separator: "&")
    }
}
