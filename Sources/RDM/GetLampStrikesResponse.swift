//
//  GetLampStrikesResponse.swift
//  
//
//  Created by Jorge Loc Rubio on 4/15/20.
//

import Foundation

/**
 This parameter is used to retrieve the number of lamp strikes or to set the counter in the device to a specific starting value.
 */
public struct GetLampStrikesResponse: MessageDataBlockProtocol, Equatable, Hashable {
    
    // MARK: - Properties
    
    public static var commandClass: CommandClass { return .getResponse }
    
    public static var parameterID: ParameterID { return .lampStrikes }
    
    public let lampStrikes: UInt32
    
    // MARK: - Initialization
    
    public init(lampStrikes: UInt32) {
        self.lampStrikes = lampStrikes
    }
}

// MARK: - Data

public extension GetLampStrikesResponse {
    
    internal static var length: Int { return MemoryLayout<UInt32>.size }
    
    init?(data: Data) {
        guard data.count == type(of: self).length
            else { return nil }
        self.init(lampStrikes: UInt32(bigEndian: UInt32(bytes: (data[0], data[1], data[2], data[3]))))
    }
    
    var data: Data {
        return Data(self)
    }
}

// MARK: - DataConvertible

extension GetLampStrikesResponse: DataConvertible {
    
    var dataLength: Int {
        return MemoryLayout<UInt32>.size
    }
    
    static func += (data: inout Data, value: GetLampStrikesResponse) {
        data += value.lampStrikes.bigEndian
    }
}