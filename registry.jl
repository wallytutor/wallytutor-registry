# -*- coding: utf-8 -*-
using Pkg
Pkg.add("LocalRegistry")
Pkg.add("YAML")

using LibGit2
using LocalRegistry
using Random
using YAML

"Create a new registry if it does not exist yet."
function createifnone(
        name::String,
        repo::String;
        path::String,
        branch::String
    )::Nothing
    registry = joinpath(path, name)

    if isdir(registry)
        @info "Found a registry at $(registry)"
    else
        create_registry(name, repo; push = true, branch)
    end

    return nothing
end

"Register a package if not dirty, otherwise a message is issued."
function saferegister(p::String; registry::String)::Nothing
    repo = try
        LibGit2.GitRepo(p)
    catch
        # Patch for repositories containing multiple packages in
        # a tree containing <repo>/src/<pkg>/{Project.toml,src/}.
        LibGit2.GitRepo(joinpath(p, "../.."))
    end

    if LibGit2.isdirty(repo)
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
        branch::String = "main",
        conf::String = "conf.yaml",
        path::String = joinpath(homedir(), ".julia", "registries")
    )
    packages = YAML.load_file(conf)["packages"]

    @assert all(isdir.(packages))

    createifnone(name, repo; path, branch)

    saferegister.(packages; registry = name)

    @info "Finished workflow"
end

workflow(
    "wallytutor-registry",
    "https://github.com/wallytutor/wallytutor-registry";
    # branch = randstring(['0':'9'; 'a':'f'])
)
