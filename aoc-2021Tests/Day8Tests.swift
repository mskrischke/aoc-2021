//
//  Day8Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 08.12.21.
//

import XCTest

class Day8Tests: XCTestCase {

    func testDay8_1() throws {
        let data = loadData()
        let simpleDigits = data.flatMap { $0.1 }.filter { [2, 4, 3, 7].contains($0.count) }.count
        XCTAssertEqual(simpleDigits, 512)
    }

    func testDay8_2() throws {
        let data = loadData()
        let sum = data.map { calcDigits(input: $0.0, output: $0.1) }.reduce(0, +)
        XCTAssertEqual(sum, 1091165)
    }

    private func calcDigits(input: [String], output: [String]) -> Int {

        func overlap(_ s0: String, _ s1: String) -> Int {
            return Set(s0.utf16).intersection(s1.utf16).count
        }

        let simpleVals = Set(input.filter { [2, 4, 3, 7].contains($0.count) })
        let vals = Set(input).subtracting(simpleVals)

        var dict: [Int: String] = [:]
        for s in simpleVals {
            switch s.count {
            case 2: dict[1] = s
            case 3: dict[7] = s
            case 4: dict[4] = s
            case 7: dict[8] = s
            default: break
            }
        }

        for v in vals {
            switch v.count {
            case 5:
                if overlap(v, dict[1]!) == 2 {
                    dict[3] = v
                } else if overlap(v, dict[4]!) == 2 {
                    dict[2] = v
                } else {
                    dict[5] = v
                }
            case 6:
                if overlap(v, dict[1]!) == 1 {
                    dict[6] = v
                } else if overlap(v, dict[4]!) == 4 {
                    dict[9] = v
                } else {
                    dict[0] = v
                }
            default:
                preconditionFailure()
            }
        }

        let number = Int(output.compactMap { e in String(dict.first(where: { $0.value == e })?.key ?? 0) }.joined(separator: ""))!
        return number
    }

    func loadData() -> [([String], [String])] {
        let d = """
            be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
            edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
            fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
            fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
            aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
            fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
            dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
            bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
            egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
            gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
            """
        let d2 = loadFile(name: "day8.txt")

        return d2.split(separator: "\n").map { String($0).components(separatedBy: " | ") }
        .map { s in
            let x = s[0].components(separatedBy: " ").map { String($0.sorted()) }
            let y = s[1].components(separatedBy: " ").map { String($0.sorted()) }
            return (x, y)
        }
    }
}
