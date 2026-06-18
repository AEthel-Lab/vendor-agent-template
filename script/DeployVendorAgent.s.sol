// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

// ─── Æthel Labs Marketplace Interface ────────────────────────────────────────
//
//  listAgent()  —  registers your agent on the decentralised marketplace.
//
//  Parameters:
//    _agentId      Unique snake_case identifier for your agent.
//                  Format:  agent_<short_descriptor>
//                  Example: agent_python_coding
//
//    _price        Access price in USDC (6-decimal integer).
//                  Formula: price_in_usd * 1_000_000
//                  Example: $5.00 USDC = 5_000_000   |   Free = 1
//
//    _metadataUri  JSON string describing your agent (see DEV ZONE below).
//
// ─────────────────────────────────────────────────────────────────────────────
interface IAethelMarketplace {
    function listAgent(
        string calldata _agentId,
        uint256 _price,
        string calldata _metadataUri
    ) external;
}

contract DeployVendorAgent is Script {
    // ─── Æthel Labs Marketplace Proxy — ARC Testnet ───────────────────────
    address constant MARKETPLACE_PROXY =
        0xD3362dB9Afa0D9e0FA6Eb9909527BFb6693AAe53;

    function run() public {
        // Reads PRIVATE_KEY from your .env file (never hardcode it here).
        uint256 developerPrivateKey = vm.envUint("PRIVATE_KEY");

        IAethelMarketplace market = IAethelMarketplace(MARKETPLACE_PROXY);

        vm.startBroadcast(developerPrivateKey);

        // ═══════════════════════════════════════════════════════════════════
        // ░░░  DEV CONFIGURATION ZONE — edit only the values below  ░░░░░░░
        // ═══════════════════════════════════════════════════════════════════

        market.listAgent(
            // ── 1. AGENT ID ───────────────────────────────────────────────
            //  Must be unique across the marketplace.
            //  Rule: lowercase letters, numbers, and underscores only.
            //  Prefix with  agent_  followed by a short descriptor.
            //  This is your permanent on-chain key — choose carefully.
            //
            //  ✓ Good:  "agent_python_coding"
            //  ✗ Bad:   "My Agent!", "pythonCoding", "0xABC..."
            "agent_your_unique_id",

            // ── 2. PRICE (USDC, 6 decimals) ───────────────────────────────
            //  Multiply your USD price by 1_000_000.
            //  Set to  1  to offer the agent for free (zero is rejected).
            //
            //  Examples:
            //    Free         →     1
            //    $1.00 USDC   →     1_000_000
            //    $5.00 USDC   →     5_000_000
            //    $15.00 USDC  →    15_000_000
            //    $25.00 USDC  →    25_000_000
            1, // TODO: set your price

            // ── 3. METADATA JSON ──────────────────────────────────────────
            //  All fields are rendered in the marketplace card UI.
            //  Keep the full string on one line (no line breaks inside).
            //
            //  Fields:
            //    title        → Display name shown on the marketplace card.
            //                   Be descriptive — this is the first thing
            //                   buyers read.  Max ~40 chars recommended.
            //    description  → One-sentence pitch for your agent.
            //                   Max 512 chars total for the whole JSON.
            //    icon         → Icon rendered on the card. Pick one:
            //                   "Code" | "ShieldCheck" | "ChartLine" |
            //                   "Translate" | "FileText" | "Gear"
            //    category     → Broad grouping label (free text).
            //                   Examples: "Programming", "Security",
            //                   "DeFi", "Finance", "Social", "Data"
            //    tags         → Array of short keyword strings (max 3).
            //
            //  Example — Python optimiser agent:
            //  {"title":"Python Code Optimizer","description":"Automated syntax auditing, dynamic memory leak tracing, and algorithmic optimizations tailored for execution pipelines.","icon":"Code","category":"Programming","tags":["Optimization","Python","Tool"]}
            '{"title":"Your Agent Display Name","description":"One-sentence description of what your agent does and who it helps.","icon":"Code","category":"Programming","tags":["Tag1","Tag2","Tag3"]}'
            // TODO: replace every value above with your own
        );

        // ═══════════════════════════════════════════════════════════════════
        // ░░░  END OF DEV CONFIGURATION ZONE                          ░░░░░░
        // ═══════════════════════════════════════════════════════════════════

        console.log("Listing broadcasted successfully.");
        console.log("Your agent is now live on the Aethel Marketplace.");

        vm.stopBroadcast();
    }
}
