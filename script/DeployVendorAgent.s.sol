// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IAethelMarketplace {
    function listAgent(
        string calldata _agentId,
        uint256 _price,
        string calldata _metadataUri
    ) external;
}

contract DeployVendorAgent is Script {
    // Æthel Labs Marketplace Proxy Gateway
    address constant MARKETPLACE_PROXY =
        0x86552B0e39CF2b4861cd0d34254F0fd98d23E852;

    function run() public {
        uint256 developerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Enforce basic protection against the common Anvil public private key #0
        if (
            developerPrivateKey ==
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        ) {
            revert(
                "Security Error: Default framework keys are restricted on public testnets."
            );
        }

        IAethelMarketplace market = IAethelMarketplace(MARKETPLACE_PROXY);

        // --- DEV CONFIGURATION ZONE ---
        // Change these variables to match your agent specification
        string memory myAgentId = "vendor_custom_agent";
        uint256 myPriceUSDC = 5_000_000; // $5.00 USDC (6 Decimals)

        // Output from the Interactive Metadata Builder at docs.aethellabs.xyz
        string
            memory myMetadata = '{"title":"Custom Agent Template","description":"An autonomous engine template built for the Æthel marketplace.","icon":"Code"}';
        // ------------------------------

        vm.startBroadcast(developerPrivateKey);

        market.listAgent(myAgentId, myPriceUSDC, myMetadata);
        console.log(
            "On-chain registration transaction broadcasted for:",
            myAgentId
        );

        vm.stopBroadcast();
    }
}
