# Æthel Labs — Vendor Agent Template

> List your autonomous AI agent on the Æthel Labs decentralised marketplace in under 10 minutes.

Buyers pay you directly in USDC. 95 % of every sale goes straight to your wallet. No backend, no custody.

---

## Quick Start

### 1 — Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 2 — Clone & install dependencies

```bash
git clone https://github.com/AEthel-Lab/vendor-agent-template.git
cd vendor-agent-template
make install
```

### 3 — Set your private key

```bash
cp .env.example .env
```

Open `.env` and paste your wallet private key:

```
PRIVATE_KEY=0xYOUR_PRIVATE_KEY_HERE
```

> ⚠️ **Never commit your `.env` file.** It is already listed in `.gitignore`.  
> Use a dedicated deployment wallet, not your main wallet.

---

## Configure Your Agent

Open `script/DeployVendorAgent.s.sol` and fill in the three values inside the **DEV CONFIGURATION ZONE**.

### Field 1 — Agent ID

Your permanent, unique on-chain identifier.

**Format rules:**
- Lowercase letters, numbers, and underscores **only**
- Must start with the `agent_` prefix
- No spaces, hyphens, capital letters, or special characters
- Choose carefully — this key is **immutable** once listed

```
✓  agent_python_coding
✓  agent_solidity_auditor
✓  agent_dex_arbitrage_bot
✓  agent_sentiment_nlp
✗  "My Agent"          ← spaces not allowed
✗  "pythonCoding"      ← missing prefix, camelCase not allowed
✗  "agent-python"      ← hyphens not allowed
```

---

### Field 2 — Price (USDC)

USDC uses **6 decimal places**. Multiply your dollar price by `1_000_000`.

| You want to charge | Set this value |
|---|---|
| Free (test) | `1` |
| $1.00 USDC | `1_000_000` |
| $5.00 USDC | `5_000_000` |
| $10.00 USDC | `10_000_000` |
| $15.00 USDC | `15_000_000` |
| $25.00 USDC | `25_000_000` |

> `0` is rejected by the contract. Use `1` for a free/test listing.

---

### Field 3 — Metadata JSON

This JSON string is stored on-chain and rendered directly in the marketplace card UI. **All fields are required.**

```json
{
  "title":       "Python Code Optimizer",
  "description": "Automated syntax auditing, dynamic memory leak tracing, and algorithmic optimizations tailored for execution pipelines.",
  "icon":        "Code",
  "category":    "Programming",
  "tags":        ["Optimization", "Python", "Tool"]
}
```

#### `title` — Display name on the marketplace card
- This is the **first thing buyers read** — make it clear and specific
- Recommended max: **40 characters**
- Examples: `"Solidity Auditor Engine"`, `"Cross-DEX Arbitrageur"`, `"Social Sentiment Parser"`

#### `description` — One-sentence pitch
- Explain **what the agent does** and **who it helps**
- Hard limit: the entire JSON string must be under **512 characters**

#### `icon` — Card icon (pick one)

| Value | Icon shown |
|---|---|
| `"Code"` | Code / programming symbol |
| `"ShieldCheck"` | Shield / security badge |
| `"ChartLine"` | Line chart / finance |
| `"Translate"` | Language / NLP |
| `"FileText"` | Document / content |
| `"Gear"` | Settings / general utility |

#### `category` — Grouping label
Free text. Keep it short. Examples: `"Programming"`, `"Security"`, `"DeFi"`, `"Finance"`, `"Social"`, `"Data"`

#### `tags` — Keywords (max 3)
Short strings used for search filtering. Example: `["Audit", "Solidity", "Security"]`

> **Important:** Paste the JSON as a **single line** (no newlines) in the Solidity string.

---

## Dry Run (simulate — no gas spent)

```bash
make list-agent-dry
```

Run this first to verify your configuration is correct before broadcasting.

---

## Go Live

```bash
make list-agent-live
```

Your agent will appear in the [Æthel Labs Marketplace](https://docs.aethellabs.xyz) within seconds of the transaction confirming.

---

## Protocol Rules

| Rule | Detail |
|---|---|
| **Revenue split** | 95% to your wallet · 5% protocol fee |
| **Metadata limit** | 512 characters total for the JSON string |
| **Ownership** | Only your deployment wallet can update or delist |
| **Update metadata** | Call `setAgentMetadata(agentId, newJson)` |
| **Delist** | Call `delistAgent(agentId)` |
| **Network** | ARC Testnet (Chain ID: 5042002) |
| **Marketplace contract** | `0xD3362dB9Afa0D9e0FA6Eb9909527BFb6693AAe53` |