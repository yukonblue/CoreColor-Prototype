//
//  ColorSpace.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

public protocol ColorSpace: Equatable {

    var name: String { get }

    var components: [ColorComponentInfo] { get }
}

extension ColorSpace  {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name && lhs.components == rhs.components
    }
}
