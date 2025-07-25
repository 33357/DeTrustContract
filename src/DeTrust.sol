// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeTrust {
    struct TrustSetting {
        address settlor; // 委托人
        address tokenAddress; // 资产地址
        uint256 depositAmount; // 注资数量
        uint256 depositCount; // 注资次数
        uint256 releaseTime; // 解锁时间
        uint256 withdrawCount; // 提现次数
        address beneficiary; // 受益人
        bool isRevocable; // 是否可撤销
    }

    struct TrustStatus {
        uint256 balance; // 当前余额
        uint256 depositedCount; // 实际注资次数
        uint256 withdrawedCount; // 实际提现次数
        uint256 nextWithdrawTime; // 下次提现时间
        bool isRevoked; // 是否已撤销
    }

    mapping(uint256 => TrustSetting) public trustSettingMap;
    mapping(uint256 => TrustStatus) public trustStatusMap;
    mapping(address => uint256[]) public settlorTrustsMap;
    mapping(address => uint256[]) public beneficiaryTrustsMap;
    uint256 public trustCount;

    event TrustDeposited(uint256 indexed trustId);
    event TrustWithdrawn(uint256 indexed trustId);
    event TrustRevoked(uint256 indexed trustId);
    event TrustCreated(
        uint256 indexed trustId,
        address indexed settlor,
        address indexed beneficiary
    );

    modifier onlySettlor(uint256 trustId) {
        require(
            msg.sender == trustSettingMap[trustId].settlor,
            "Only settlor can call"
        );
        _;
    }

    modifier onlyNotRevoked(uint256 trustId) {
        require(!trustStatusMap[trustId].isRevoked, "Trust is revoked");
        _;
    }

    modifier onlyBeneficiary(uint256 trustId) {
        require(
            msg.sender == trustSettingMap[trustId].beneficiary,
            "Only beneficiary can call"
        );
        _;
    }

    function create(
        address tokenAddress,
        uint256 depositAmount,
        uint256 depositCount,
        uint256 withdrawCount,
        address beneficiary,
        uint256 releaseTime,
        bool isRevocable
    ) external {
        require(releaseTime > block.timestamp, "Release time in future");
        trustSettingMap[trustCount] = TrustSetting({
            settlor: msg.sender,
            tokenAddress: tokenAddress,
            depositAmount: depositAmount,
            depositCount: depositCount,
            withdrawCount: withdrawCount,
            beneficiary: beneficiary,
            releaseTime: releaseTime,
            isRevocable: isRevocable
        });
        trustStatusMap[trustCount].nextWithdrawTime = releaseTime;
        settlorTrustsMap[msg.sender].push(trustCount);
        beneficiaryTrustsMap[beneficiary].push(trustCount);
        emit TrustCreated(trustCount++, msg.sender, beneficiary);
    }

    function deposit(
        uint256 trustId
    ) public payable onlySettlor(trustId) onlyNotRevoked(trustId) {
        require(
            trustSettingMap[trustId].depositCount >
                trustStatusMap[trustId].depositedCount,
            "Deposit time exceeded"
        );
        if (trustSettingMap[trustId].tokenAddress == address(0)) {
            require(
                msg.value == trustSettingMap[trustId].depositAmount,
                "Deposit ether failed"
            );
        } else {
            require(
                IERC20(trustSettingMap[trustId].tokenAddress).transferFrom(
                    msg.sender,
                    address(this),
                    trustSettingMap[trustId].depositAmount
                ),
                "Deposit ERC20 failed"
            );
        }
        trustStatusMap[trustId].balance += trustSettingMap[trustId]
            .depositAmount;
        trustStatusMap[trustId].depositedCount++;
        emit TrustDeposited(trustId);
    }

    function revoke(
        uint256 trustId
    ) external onlySettlor(trustId) onlyNotRevoked(trustId) {
        require(trustSettingMap[trustId].isRevocable, "Trust is not revocable");
        trustStatusMap[trustId].isRevoked = true;
        if (trustSettingMap[trustId].tokenAddress == address(0)) {
            payable(trustSettingMap[trustId].settlor).transfer(
                trustStatusMap[trustId].balance
            );
        } else {
            IERC20(trustSettingMap[trustId].tokenAddress).transfer(
                trustSettingMap[trustId].settlor,
                trustStatusMap[trustId].balance
            );
        }
        trustStatusMap[trustId].balance = 0;
        emit TrustRevoked(trustId);
    }

    function withdraw(
        uint256 trustId
    ) external onlyBeneficiary(trustId) onlyNotRevoked(trustId) {
        require(
            block.timestamp >= trustStatusMap[trustId].nextWithdrawTime,
            "Not reached nextWithdrawTime"
        );
        require(
            trustStatusMap[trustId].withdrawedCount <
                trustSettingMap[trustId].withdrawCount,
            "Withdraw time exceeded"
        );
        uint256 withdrawAmount = trustStatusMap[trustId].balance /
            (trustSettingMap[trustId].withdrawCount -
                trustStatusMap[trustId].withdrawedCount);
        trustStatusMap[trustId].balance -= withdrawAmount;
        trustStatusMap[trustId].withdrawedCount++;
        if (trustSettingMap[trustId].tokenAddress == address(0)) {
            payable(trustSettingMap[trustId].beneficiary).transfer(
                withdrawAmount
            );
        } else {
            IERC20(trustSettingMap[trustId].tokenAddress).transfer(
                trustSettingMap[trustId].beneficiary,
                withdrawAmount
            );
        }
        emit TrustWithdrawn(trustId);
    }
}
