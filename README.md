# DeTrustContarct

## Address

```
inj-test:
0xE99938fc114b20f818C9202955ba8C8c4a5a79B9

bsc-test:
0xE99938fc114b20f818C9202955ba8C8c4a5a79B9

sepolia:
0xE99938fc114b20f818C9202955ba8C8c4a5a79B9
```

## Abi
```javascript
[
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "settlor",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			}
		],
		"name": "TrustCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			}
		],
		"name": "TrustDeposited",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			}
		],
		"name": "TrustRevoked",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			}
		],
		"name": "TrustWithdrawn",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "beneficiaryTrustsMap",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "tokenAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "depositAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "withdrawCount",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "releaseTime",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "isRevocable",
				"type": "bool"
			}
		],
		"name": "create",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			}
		],
		"name": "deposit",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			}
		],
		"name": "revoke",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "settlorTrustsMap",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "trustCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "trustSettingMap",
		"outputs": [
			{
				"internalType": "address",
				"name": "settlor",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "tokenAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "depositAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "releaseTime",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "withdrawCount",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "beneficiary",
				"type": "address"
			},
			{
				"internalType": "bool",
				"name": "isRevocable",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "trustStatusMap",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "balance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositedCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "withdrawedCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "nextWithdrawTime",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "isRevoked",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "trustId",
				"type": "uint256"
			}
		],
		"name": "withdraw",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
```