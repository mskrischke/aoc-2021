//
//  Day6Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 06.12.21.
//

import XCTest
import Algorithms

class Day6Tests: XCTestCase {

    func testDay6_1() throws {
        var d = loadData()

        var newPopulation: [Int] = []

        for iteration in 0..<80 {
            for x in d.indices {
                if d[x] == 0 {
                    newPopulation.append(8)
                    d[x] = 6
                } else {
                    d[x] -= 1
                }
            }
            d.append(contentsOf: newPopulation)
            newPopulation.removeAll(keepingCapacity: true)
            print("iteration: \(iteration)")
        }

        XCTAssertEqual(d.count, 372984)
    }

    func testDay6_2() throws {

        var fishAges = Array(repeating: 0, count: 9)
        for f in loadData() {
            fishAges[f] += 1
        }

        for iteration in 0..<256 {
            var newFish = fishAges
            for index in fishAges.indices.reversed() {
                if index == 0 {
                    newFish[8] = fishAges[index]
                    newFish[6] += fishAges[index]
                } else {
                    newFish[index - 1] = fishAges[index]
                }
            }
            fishAges = newFish
            print("iteration: \(iteration)")
        }
        XCTAssertEqual(fishAges.reduce(0, +), 1681503251694)
    }

    func loadData() -> [Int] {
//        return [3, 4, 3, 1, 2]
        return loadFile(name: "day6.txt")
            .split(separator: ",")
            .map { Int(String($0).trimmingCharacters(in: .whitespacesAndNewlines))! }
    }
}
