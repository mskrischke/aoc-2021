//
//  Day1Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 03.12.21.
//

import XCTest

class Day1Tests: XCTestCase {

    func testDay1_1() throws {
        let data = loadData()
        XCTAssertEqual(measure(data: data), 1184)
    }

    func testDay1_2() throws {
        let data = loadData()
        let steps = data.count - 2
        let aggregatedData: [Int] = (0..<steps).map { (index: Int) -> Int in data[index] + data[index + 1] + data[index + 2] }
        XCTAssertEqual(measure(data: aggregatedData), 1158)
    }

    private func measure(data: [Int]) -> Int {
        var increased = 0
        for index in 1..<data.count {
            if data[index] > data[index - 1] {
                increased += 1
            }
        }
        return increased
    }

    private func loadData() -> [Int] {
//        return [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
        return loadFile(name: "day1.txt").split(separator: "\n").compactMap { Int($0) }
    }
}
