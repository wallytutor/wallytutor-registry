# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")

using LocalRegistry

const repo = "D:/Repositories"
const name = "wallytutor-registry"
const rurl = "https://github.com/wallytutor/wallytutor-registry"

if !isfile("Registry.toml")
    create_registry(name, rurl, description = "WallyTutor packages")
end

packages = [
    "$(repo)/DryTooling.jl",
    "$(repo)/RadCalNet.jl"
]

register.(packages; registry = name)
