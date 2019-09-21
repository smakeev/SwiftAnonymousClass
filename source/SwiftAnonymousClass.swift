//
//  SwiftAnonymousClass.swift
//  SwiftAnonymousClass
//
//  Created by Sergey Makeev on 20/09/2019.
//  Copyright © 2019 Sergey Makeev. All rights reserved.
//
//
public func _new<Type>(_ objectCreator:()->Type) -> Type {
	return objectCreator()
}
