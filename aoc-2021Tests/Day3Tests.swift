//
//  Day3Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 03.12.21.
//

import XCTest

class Day3Tests: XCTestCase {

    func testDay3_1() throws {
        let data = loadData()
        let columns = data[0].count

        let result = data.reduce(into: Array(repeating: 0, count: columns)) { (result: inout [Int], value: [Int]) in
            (0..<columns).forEach { result[$0] += value[$0] }
        }.map { i in
            Double(i) >= Double(data.count) * 0.5 ? 1 : 0
        }

        let gamma = result.binaryToInt()
        let epsilon = result.map { $0 == 0 ? 1 : 0 }.binaryToInt()
        XCTAssertEqual(gamma! * epsilon!, 2743844)
    }

    func testDay3_2() throws {
        let data = loadData()

        let oxygen = reduce(data, filter: { $0 == $1 }).binaryToInt()
        let co2 = reduce(data, filter: { $0 != $1 }).binaryToInt()
        XCTAssertEqual(oxygen! * co2!, 6677951)
    }

    private func reduce(_ data: [[Int]], filter: (Int, Int) -> Bool) -> [Int] {
        let columns = data[0].count

        var d = data
        for i in 0..<columns where d.count > 1 {
            let majority = Double(d.map { $0[i] }.reduce(0, +)) >= Double(d.count)  * 0.5 ? 1 : 0
            d = d.filter { filter($0[i], majority) }
        }
        return d[0]
    }

    func loadData() -> [[Int]]{
        let test = """
            00100
            11110
            10110
            10111
            10101
            01111
            00111
            11100
            10000
            11001
            00010
            01010
            """

        return loadFile(name: "day3.txt")
            .split(separator: "\n")
            .map { $0.map { Int(String($0))! } }
    }
}

extension Array where Element == Int {

    func binaryToInt() -> Int? {
        return Int(self.map { String($0) }.joined(), radix: 2)
    }
}
