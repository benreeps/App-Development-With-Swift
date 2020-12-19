//
//  CellNumber.swift
//  GuidedProject-ToDoList
//
//  Created by Benjamin Reeps on 12/16/20.
//

import Foundation
import UIKit

struct CellNumber {
    var number: Int
    
    static func loadCellNumbers() -> [CellNumber]? {
        return nil 
    }
  
    static func loadSampleCellNumbers() -> [CellNumber] {
        let n1 = CellNumber(number: 1)
        let n2 = CellNumber(number: 2)
        let n3 = CellNumber(number: 3)
        let n4 = CellNumber(number: 4)
        let n5 = CellNumber(number: 5)
        let n6 = CellNumber(number: 6)
        let n7 = CellNumber(number: 7)
        let n8 = CellNumber(number: 8)
        let n9 = CellNumber(number: 9)
        let n10 = CellNumber(number: 10)
        let n11 = CellNumber(number: 11)
        let n12 = CellNumber(number: 12)
        let n13 = CellNumber(number: 13)
        let n14 = CellNumber(number: 14)
        let n15 = CellNumber(number: 15)
        let n16 = CellNumber(number: 16)
        let n17 = CellNumber(number: 17)
        let n18 = CellNumber(number: 18)
        let n19 = CellNumber(number: 19)
        let n20 = CellNumber(number: 20)
        
        return [n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20]
    }
}
