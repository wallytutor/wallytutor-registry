# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")

using LocalRegistry

name = "wallytutor-registry"
rurl = "https://github.com/wallytutor/wallytutor-registry"

create_registry(name, rurl, description = "WallyTutor packages")

root = "D:/Repositories"

packages = [
    "$(root)/DryTooling.jl",
    "$(root)/RadCalNet.jl"
]

register.(packages; registry = name)
