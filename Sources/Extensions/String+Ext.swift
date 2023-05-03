//
//  String+Ext.swift
//  
//
//  Created by scchn on 2023/5/2.
//

import Foundation

extension String {
    
    func ifEmpty(_ placeholder: String) -> String {
        isEmpty ? placeholder : self
    }
    
}
