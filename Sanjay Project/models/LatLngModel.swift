//
//  LatLngModel.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 19/06/24.
//

import Foundation


struct Location: Decodable {
    let lat, lng, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let current: Current?
    let hourly: Hourly?
  

    enum CodingKeys: String, CodingKey {
        case lat = "latitude"
        case lng = "longitude"
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case current
        case hourly
    }
}

struct Current: Decodable {
    let time: String?
    let interval : Int?
    let windSpeed10M, temperature2M: Double?

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]?
    let temperature2M: [Double]?
    let relativeHumidity2M: [Int]?
    let windSpeed10M: [Double]?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
    }
    
}

