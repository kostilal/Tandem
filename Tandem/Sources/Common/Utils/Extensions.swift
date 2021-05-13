//
//  Constants.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data, keyPath: [String]) throws -> T where T: Decodable {
        let jsonDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        let keyedData = try JSONSerialization.data(withJSONObject: jsonDict?.getValue(forKeyPath: keyPath) ?? [:], options: .prettyPrinted)
        return try self.decode(type, from: keyedData)
    }
}

extension Dictionary where Key: Hashable, Value: Any {
    func getValue(forKeyPath components: [Any]) -> Any? {
        var comps = components
        let key = comps.remove(at: 0)
        if let k = key as? Key {
            if comps.count == 0 {
                if self[k] is NSNull {
                    return nil
                }
                
                return self[k]
            }
            if let v = self[k] as? [AnyHashable: Any] {
                return v.getValue(forKeyPath: comps)
            }
        }
        
        return nil
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
