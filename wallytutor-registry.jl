# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")

using LocalRegistry

name = "wallytutor-registry"
rurl = "https://github.com/wallytutor/wallytutor-registry"

create_registry(name, rurl, description = "WallyTutor packages")

package = "D:/DryTooling.jl"
register(package; registry = name)
