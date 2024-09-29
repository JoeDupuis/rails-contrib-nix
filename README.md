# Rails Contrib Nix

Nix based environment to contribute to Rails.

Setting up a dev environment from scratch for contributing to Rails is not trivial. The proposed alternative is to use dev containers or a VM which comes with drawbacks.

This project aim to make it easy to run everything natively without a VM or a dev container.


## Instructions

### Setup
You will need
- devenv
- nix
- direnv

- Follow devenv and nix installation instructions (step 1 and 2) [here](https://devenv.sh/getting-started/).

- Install [direnv](https://direnv.net/). There is likely a package for your distro (linux) or use brew on Mac.

- cd into the rails contrib nix repo

- `direnv allow` to allow list the repo and let direnv install the dependencies.

- `bin/setup` to clone rails, flush state and install gems. If something break after an upgrade (ruby or rails-contrib-nix for example), try running `bin/setup` again.

- `bin/start` to start all services.

### Usage

Rails should have been cloned into the workspace folder and symlinked at the root of the repo.
Once everything is installed and the services are started, you can start working on Rails!
Clone other required dependencies and your dev Rails apps (`--dev` option on Rails new ) inside the workspace folder.
