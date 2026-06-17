-include .env

.PHONY: all clean build install list-agent-dry list-agent-live

# Install dependencies
install:
	forge install foundry-rs/forge-std --no-commit

# Build contracts
build:
	forge build

# Local dry-run simulation (Verifies authorization and gas execution boundaries)
list-agent-dry:
	@forge script script/DeployVendorAgent.s.sol:DeployVendorAgent --rpc-url arc_testnet

# Broadcast live transaction to the active L1 ledger
list-agent-live:
	@forge script script/DeployVendorAgent.s.sol:DeployVendorAgent --rpc-url arc_testnet --broadcast