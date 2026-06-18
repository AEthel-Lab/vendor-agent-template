// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

// ─── Æthel Labs Marketplace Interface ────────────────────────────────────────
//
//  listAgent() — registers your agent on the decentralised marketplace.
//
//  This script reads three variables you set in the DEV ZONE below:
//    MY_AGENT_ID    → your unique on-chain identifier
//    MY_PRICE_USDC  → your listing price in USDC (6 decimals)
//    MY_METADATA    → JSON string displayed on the marketplace card
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
    // Æthel Labs Marketplace Proxy — ARC Testnet
    address constant MARKETPLACE_PROXY =
        0xD3362dB9Afa0D9e0FA6Eb9909527BFb6693AAe53;

    function run() public {
        // Reads PRIVATE_KEY from your .env file — never hardcode it here.
        uint256 developerPrivateKey = vm.envUint("PRIVATE_KEY");

        IAethelMarketplace market = IAethelMarketplace(MARKETPLACE_PROXY);

        vm.startBroadcast(developerPrivateKey);

        // ═══════════════════════════════════════════════════════════════════
        // ░░░  DEV CONFIGURATION ZONE — edit only the three values below ░░░
        // ═══════════════════════════════════════════════════════════════════


        // ── STEP 1 · AGENT ID ─────────────────────────────────────────────
        //
        //  Your permanent, unique on-chain identifier.
        //  Rules:
        //    • Start with the prefix   agent_
        //    • Lowercase letters, numbers, and underscores ONLY
        //    • No spaces, hyphens, capital letters, or symbols
        //    • Choose carefully — this key is immutable once listed
        //
        //  ✓  "agent_python_coding"
        //  ✓  "agent_solidity_auditor"
        //  ✓  "agent_dex_arbitrage_bot"
        //  ✗  "My Agent"     ← spaces not allowed
        //  ✗  "pythonBot"    ← missing agent_ prefix
        //  ✗  "agent-nlp"    ← hyphens not allowed
        //
        string memory MY_AGENT_ID = "agent_your_unique_id"; // ← CHANGE THIS


        // ── STEP 2 · PRICE ────────────────────────────────────────────────
        //
        //  USDC has 6 decimal places.
        //  Multiply your dollar price by 1_000_000.
        //  Use 1 for a free / test listing (0 is rejected by the contract).
        //
        //   Free / Test   →             1
        //   $1.00 USDC    →     1_000_000
        //   $5.00 USDC    →     5_000_000
        //   $10.00 USDC   →    10_000_000
        //   $15.00 USDC   →    15_000_000
        //   $25.00 USDC   →    25_000_000
        //
        uint256 MY_PRICE_USDC = 1; // ← CHANGE THIS


        // ── STEP 3 · METADATA ─────────────────────────────────────────────
        //
        //  JSON string rendered on your marketplace card.
        //  Must be a single line — no line breaks inside the string.
        //  Total length of the JSON must be under 512 characters.
        //
        //  Fields:
        //    "title"       Display name on the card (max ~40 chars).
        //                  This is what buyers see first — be specific.
        //
        //    "description" One-sentence pitch (what it does, who it helps).
        //
        //    "icon"        Icon shown on the card. Choose one string:
        //                    "Code"        → code / programming symbol
        //                    "ShieldCheck" → shield / security badge
        //                    "ChartLine"   → line chart / finance
        //                    "Translate"   → language / NLP
        //                    "FileText"    → document / content
        //                    "Gear"        → settings / general utility
        //
        //    "category"    Grouping label. E.g. "Programming", "Security",
        //                  "DeFi", "Finance", "Social", "Data"
        //
        //    "tags"        Array of up to 3 short keyword strings.
        //
        //  Example (Python optimizer):
        //  {"title":"Python Code Optimizer","description":"Automated syntax auditing and algorithmic optimizations for execution pipelines.","icon":"Code","category":"Programming","tags":["Optimization","Python","Tool"]}
        //
        string memory MY_METADATA = '{"title":"Your Agent Display Name","description":"One-sentence description of what your agent does and who it helps.","icon":"Code","category":"Programming","tags":["Tag1","Tag2","Tag3"]}'; // ← CHANGE THIS


        // ═══════════════════════════════════════════════════════════════════
        // ░░░  END OF DEV CONFIGURATION ZONE — do not edit below this line ░
        // ═══════════════════════════════════════════════════════════════════

        market.listAgent(MY_AGENT_ID, MY_PRICE_USDC, MY_METADATA);

        console.log("Listing broadcasted successfully.");
        console.log("Agent ID:", MY_AGENT_ID);
        console.log("Your agent is now live on the Aethel Marketplace.");

        vm.stopBroadcast();
    }
}
