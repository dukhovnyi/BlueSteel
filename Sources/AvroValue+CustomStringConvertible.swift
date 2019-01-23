//
//  AvroValue+CustomStringConvertible.swift
//  BlueSteel
//
//  Created by Joris Borgdorff on 17/01/2019.
//  Copyright © 2019 RADAR-base. All rights reserved.
//

import Foundation

extension AvroValue: CustomStringConvertible {
    public var description: String {
        switch self {
        case .avroNull:
            return "null"

        case .avroBoolean(let value):
            return "\(value)"

        case .avroInt(let value):
            return "\(value)"

        case .avroLong(let value):
            return "\(value)L"

        case .avroFloat(let value):
            return "\(value)f"

        case .avroDouble(let value):
            return "\(value)d"

        case .avroBytes(let value):
            return "\(value)"

        case .avroString(let value):
            return "\"\(value)\""

        // Complex Types
        case .avroArray(_, let values):
            return "\(values)"

        case .avroMap(_, let values):
            return "\(values)"

        case .avroUnion(let schemaOptions, let index, let value):
            let typeNames = schemaOptions.map { $0.typeName }.joined(separator: ", ")
            return "union([\(typeNames)][\(index)]: \(value))"

        case .avroRecord(.avroRecord(let name, let fieldSchemas), let values):
            let fields = fieldSchemas.map { field in
                    if let value = values[field.name] {
                        return "\(field.name): \(value)"
                    } else if let defaultValue = field.defaultValue {
                        return "\(field.name): \(defaultValue)"
                    } else {
                        return "\(field.name): ???"
                    }
                }.joined(separator: ", ")
            return "\(name)<record>([\(fields)]))"

        case .avroEnum(.avroEnum(let name, let symbols), let index, let value):
            return "\(name)<enum>([\(symbols.joined(separator: ", "))][\(index)]: \(value))"

        case .avroFixed(.avroFixed(let name, _), let value):
            return "\(name)<fixed>(\(value))"

        default:
            return "unknown"
        }
    }
}
