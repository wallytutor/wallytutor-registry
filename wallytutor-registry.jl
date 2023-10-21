# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")

using LocalRegistry

name = "wallytutor-registry"
rurl = "https://github.com/wallytutor/wallytutor-registry"

create_registry(name, rurl, description = "WallyTutor packages")

packages = [
    "D:/DryTooling.jl",
    "D:/RadCalNet.jl"
]
register.(packages; registry = name)
