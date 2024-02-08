build:
	nix build .#homeConfigurations.x86_64-linux.reyhan.activationPackage --show-trace
build-osx:
	nix build .#homeConfigurations.x86_64-darwin.vicz.activationPackage --show-trace

activate:
	./result/activate
