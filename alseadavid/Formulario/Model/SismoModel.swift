//
//  SismoModel.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import Foundation

// MARK: - SismosModel
class SismosModel: Codable {
    let features: [Feature]

    init(features: [Feature]) {
        self.features = features
    }
}

// MARK: - Feature
class Feature: Codable {
    let properties: Properties
    let geometry: Geometry

    init(properties: Properties, geometry: Geometry) {
        self.properties = properties
        self.geometry = geometry
    }
}

// MARK: - Geometry
class Geometry: Codable {
    let type: String
    let coordinates: [Double]

    init(type: String, coordinates: [Double]) {
        self.type = type
        self.coordinates = coordinates
    }
}

// MARK: - Properties
class Properties: Codable {
    let mag: Double
    let url, detail: String
    let title: String

    init(mag: Double, url: String, detail: String, title: String) {
        self.mag = mag
        self.url = url
        self.detail = detail
        self.title = title
    }
}
