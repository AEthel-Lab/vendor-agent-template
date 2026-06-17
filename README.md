# Æthel Labs Vendor Agent Template

A streamlined, production-grade Foundry development starter kit for compiling, testing, and listing autonomous agents on the Æthel Labs decentralized infrastructure marketplace.

##  Onboarding & Setup Sequence


### 1. Prerequisite Installations
Ensure you have the core Foundry toolchain installed on your local environment. If you do not have it, initialize it by executing:
```bash
curl -L [https://foundry.paradigm.xyz](https://foundry.paradigm.xyz) | bash
foundryup
```

## 2 Repository Initialization
Clone this template repository under the active corporate namespace and pull down the standard testing packages:
```bash
git clone [https://github.com/AEthel-Lab/vendor-agent-template.git](https://github.com/AEthel-Lab/vendor-agent-template.git)
cd vendor-agent-template
make install
```

## 3 Environment Allocation 
```bash
cp .env.example .env
```

Open the newly created `.env` file in your preferred text editor and input your cryptographic private key string into the `PRIVATE_KEY` variable slot.

⚠️ CRITICAL SECURITY WARNING: Never commit real active private keys to public source repositories. The automation pipeline explicitly runs a runtime interception check that forcefully crashes and rejects the transaction if default local testing framework keys (such as Anvil/Hardhat Account #0) are detected, protecting you from losing gas funds.

## 4 Configure Agent Parameters

Navigate to `script/DeployVendorAgent.s.sol` and modify the fields directly inside the designated DEV CONFIGURATION ZONE:
                                                            
`myAgentId`: Assign a unique alphanumeric identifier string for your agent.

`myPriceUSDC`: Define your access licensing price point denominated in 6-decimals (e.g., $5.00 = 5000000).

`myMetadata`: Paste the exact string payload compiled for you by our Interactive Metadata Builder at `[https://docs.aethellabs.xyz]`.


## 5 Local Risk-Free Simulation
```bash
make list-agent-dry
```
## 6 Live Deployment
```bash
make list-agent-live
```

##  Protocol Specifications & Mechanics

95/5 Automated Fee Settlement: The underlying smart contracts operate on a trustless, zero-custody routing mechanism. The moment a user licenses your agent, 95% of the USDC payment is natively pushed directly to your developer registration wallet address, while a 5% platform cut is funneled to the protocol treasury.

Metadata Sanitization Constraints: To maintain frontend layout fidelity and system security, all text passed via the `metadataUri` string fields goes through an automated client-side sanitization layer. All raw HTML, inline event triggers, and `javascript:` hooks are aggressively stripped, and inputs are capped at a hard limit of  `512`characters

Immutable Lifecycle Management: Only the original developer wallet that signed the deployment transaction has authorization rights to call operational adjustments, modify structural parameter values via `setAgentMetadata` or remove listings using `delistAgent`.