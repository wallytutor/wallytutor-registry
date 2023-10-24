# WallyTutor registry

Local registry creation for my Julia packages.

1. Clone this repository anywhere in the target machine.
1. Edit the full path of packages repositories to register in [conf.yaml](conf.yaml).
1. Commit all changes and manually execute [registry.jl](registry.jl).

**IMPORTANT:** at any time when trying to install packages from this registry (or any other local registry), there must be no dangling commits in the registry repository. Check everything has been commited and pushed so that it works as expected.
