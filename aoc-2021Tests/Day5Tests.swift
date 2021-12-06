//
//  Day5Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 06.12.21.
//

import Algorithms
import XCTest

class Day5Tests: XCTestCase {

    func testDay5_1() throws {

        let data = loadData()
        let max = data
            .compactMap { $0 }
            .flatMap { [$0.0, $0.1] }
            .flatMap { [$0.x, $0.y] }
            .max()! + 1

        var field = Array(repeating: Array(repeating: 0, count: max), count: max)

        for d in data {
            guard d.0.x == d.1.x || d.0.y == d.1.y else {
                continue
            }

            if d.0.x != d.1.x {
                let xs = [d.0.x, d.1.x].sorted()
                for x in xs[0] ... xs[1] {
                    field[d.0.y][x] += 1
                }
            } else if d.0.y != d.1.y {
                let ys = [d.0.y, d.1.y].sorted()
                for y in ys[0] ... ys[1] {
                    field[y][d.0.x] += 1
                }
            }
        }

//        debug(field)

        let dangerousFields = field.flatMap { $0.compactMap { $0 } }.filter { $0 >= 2 }.count
        XCTAssertEqual(dangerousFields, 5084)
    }

    func testDay5_2() throws {
        let data = loadData()
        let max = data
            .compactMap { $0 }
            .flatMap { [$0.0, $0.1] }
            .flatMap { [$0.x, $0.y] }
            .max()! + 1

        var field = Array(repeating: Array(repeating: 0, count: max), count: max)

        for d in data {
            if d.0.x == d.1.x {
                let ys = [d.0.y, d.1.y].sorted()
                for y in ys[0] ... ys[1] {
                    field[y][d.0.x] += 1
                }
            } else {
                let v = [d.0, d.1].sorted(by: { $0.x < $1.x })

                let m = v[0].y == v[1].y ? 0 : v[0].y < v[1].y ? 1 : -1
                for (index, x) in (v[0].x ... v[1].x).enumerated() {
                    field[v[0].y + m * index][x] += 1
                }
            }
        }

        //        debug(field)
        let dangerousFields = field.flatMap { $0.compactMap { $0 } }.filter { $0 >= 2 }.count
        XCTAssertEqual(dangerousFields, 17882)
    }

    private func debug(_ field: [[Int]]) {
        for row in field {
            for c in row {
                if c == 0 {
                    print(".", terminator: "")
                } else {
                    print(c, terminator: "")
                }
            }
            print("")
        }
    }

    func loadData() -> [(Vec2, Vec2)] {
        let data = """
            0,9 -> 5,9
            8,0 -> 0,8
            9,4 -> 3,4
            2,2 -> 2,1
            7,0 -> 7,4
            6,4 -> 2,0
            0,9 -> 2,9
            3,4 -> 1,4
            0,0 -> 8,8
            5,5 -> 8,2
            """

        return loadFile(name: "day5.txt")
            .split(separator: "\n")
            .map { String($0).components(separatedBy: " -> ") }
            .map { arr -> ([Int], [Int]) in
                 let c0 = arr[0].split(separator: ",").map { Int(String($0))! }
                 let c1 = arr[1].split(separator: ",").map { Int(String($0))! }
                 return (c0, c1)
            }
            .map { (Vec2(x: $0.0[0], y: $0.0[1]), Vec2(x: $0.1[0], y: $0.1[1])) }
    }
}
