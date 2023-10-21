# WallyTutor registry

Local registry creation for my Julia packages.

1. Clone this repository to `$HOME/.julia/registries`
1. Fix path of repositories to add in `packages` variable in [registry.jl](registry.jl)
1. Commit any changes to this repository and manually execute the lines of `registry.jl`

**IMPORTANT:** at any time when trying to install packages from this registry (or any other local registry), there must be no dangling commits in the registry repository. Check everything has been commited and pushed so that it works as expected.
