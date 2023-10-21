# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")

using LocalRegistry

name = "WallyTutor"
rurl = "https://github.com/wallytutor/wallytutor-registry"

create_registry(name, rurl, description = "WallyTutor packages")

package = "../DryTooling.jl"
register(package; registry = name)
