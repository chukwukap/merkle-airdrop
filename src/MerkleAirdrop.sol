// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import {BobToken} from "./BobToken.sol";

contract MerkleAirdrop {
    // some list of addresses
    // allow someone in the list to claim tokens

    address[] claimers;
    bytes32 private immutable i_merkleRoot;
    BobToken bobToken;

    // merkle proofs
    constructor(bytes32 merkleRoot, address bobTokenAddress) {
        i_merkleRoot = merkleRoot;
        bobToken = BobToken(bobTokenAddress);
    }

    function claim(
        address account,
        uint256 amount,
        bytes32[] calldata proof
    ) external {
        // verify proof
        // verify address is in list
        // mint tokens

        bytes32 leaf = keccak256(
            bytes.concat(
                keccak256(abi.encodePacked(account)),
                keccak256(abi.encodePacked(amount))
            )
        );
        require(
            MerkleProof.verifyCalldata(proof, i_merkleRoot, leaf),
            "Invalid proof"
        );
        bobToken.mint(account, amount);
    }
}
