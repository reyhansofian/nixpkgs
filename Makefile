build:
	nix build .#homeConfigurations.x86_64-linux.reyhan.activationPackage --show-trace

activate:
	./result/activate
