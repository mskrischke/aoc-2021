//
//  Day9Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 09.12.21.
//

import XCTest

class Day9Tests: XCTestCase {

    func testDay9_1() throws {
        let field = loadData()
        let risk = findMinimums(field: field).map { field[$0.y][$0.x] + 1 }.reduce(0, +)
        XCTAssertEqual(risk, 541)
    }

    func testDay9_2() throws {
        let field = loadData()
        var basinSizes: [Int] = []
        for minimum in findMinimums(field: field) {
            var basin: Set<Vec2> = []
            flow(field: field, start: minimum, basin: &basin)
            basinSizes.append(basin.count)
        }
        XCTAssertEqual(basinSizes.sorted(by: >)[0..<3].reduce(1, *), 847504)
    }

    private func findMinimums(field: [[Int]]) -> [Vec2] {
        var minimums: [Vec2] = []
        for (y, row) in field.enumerated() {
            for (x, vent) in row.enumerated() {
                let left = x > 0 ? field[y][x - 1] : Int.max
                let right = x < row.count - 1 ? field[y][x + 1] : Int.max
                let top = y > 0 ? field[y - 1][x] : Int.max
                let bottom = y < field.count - 1 ? field[y + 1][x] : Int.max

                if vent < left && vent < right && vent < top && vent < bottom {
                    minimums.append(Vec2(x: x, y: y))
                }
            }
        }
        return minimums
    }

    private func flow(field: [[Int]], start: Vec2, basin: inout Set<Vec2>) {
        basin.insert(start)

        let left = Vec2(x: start.x - 1, y: start.y)
        if start.x > 0 && field.value(at: left) < 9 && !basin.contains(left) {
            flow(field: field, start: left, basin: &basin)
        }

        let right = Vec2(x: start.x + 1, y: start.y)
        if start.x < field[0].count - 1 && field.value(at: right) < 9 && !basin.contains(right) {
            flow(field: field, start: right, basin: &basin)
        }

        let top = Vec2(x: start.x, y: start.y - 1)
        if start.y > 0 && field.value(at: top) < 9 && !basin.contains(top) {
            flow(field: field, start: top, basin: &basin)
        }

        let bottom = Vec2(x: start.x, y: start.y + 1)
        if start.y < field.count - 1 && field.value(at: bottom) < 9 && !basin.contains(bottom) {
            flow(field: field, start: bottom, basin: &basin)
        }
    }

    private func loadData() -> [[Int]] {
        let d = """
            2199943210
            3987894921
            9856789892
            8767896789
            9899965678
            """
        let d2 = loadFile(name: "day9.txt")

        return d2.split(separator: "\n").map { String($0).compactMap { Int(String($0)) } }
    }
}

private extension Array where Element == [Int] {

    func value(at pos: Vec2) -> Int {
        return self[pos.y][pos.x]
    }
}
