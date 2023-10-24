# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")

using LocalRegistry
using YAML

data = YAML.load_file("conf.yaml")
packages = map(p->joinpath(data["reposroot"], p), data["packages"])

@assert all(isdir.(packages))

const name = "wallytutor-registry"
const repo = "https://github.com/wallytutor/wallytutor-registry"

try
    create_registry(
        name, repo;
        description = "WallyTutor packages",
        push        = true
    )
catch
end

registry = joinpath(homedir(), ".julia", "registries", name)

run(Cmd(`git pull`), dir = registry)

register.(packages; registry = name)
