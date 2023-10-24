# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")
Pkg.add("YAML")

using LibGit2
using LocalRegistry
using YAML

"Create a new registry if it does not exist yet."
function createifnone(
        name::String,
        repo::String;
        path::String
    )::Nothing
    registry = joinpath(path, name)

    if isdir(registry)
        @info "Found a registry at $(registry)"
    else
        create_registry(name, repo; push = false, branch = "main")
        run(Cmd(`git pull`, dir = registry))
        run(Cmd(`git push --set-upstream origin main`, dir = registry))
    end

    return nothing
end

"Register a package if not dirty, otherwise a message is issued."
function saferegister(p::String; registry::String)::Nothing
    if LibGit2.isdirty(LibGit2.GitRepo(p))
        @warn "\
        Target $(p) is dirty!
        First review and commit changes manually then try again.
        "
    else
        register(p; registry)
    end

    return nothing
end

"Manages workflow of registry creation and packages registering."
function workflow(
        name::String,
        repo::String; 
        conf::String = "conf.yaml",
        path::String = joinpath(homedir(), ".julia", "registries")
    )
    data = YAML.load_file(conf)

    packages = map(p->joinpath(data["root"], p), data["packages"])

    @assert all(isdir.(packages))

    createifnone(name, repo; path)

    saferegister.(packages; registry = name)
end

workflow(
    "wallytutor-registry",
    "https://github.com/wallytutor/wallytutor-registry"
)
