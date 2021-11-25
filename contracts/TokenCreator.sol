// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./factories/SimpleToken.sol";

struct Token {
    string name;
    bytes32 factory;
    address tokenAddress;
}

/**
 * @title A Creator for Tokens
 * @dev Currently only creates SimpleToken
 * @dev Saves address into _child
 */
contract TokenCreator is Ownable {
    address _child;
    mapping(address => Token[]) public tokensOfOwner;

    event CreatedSimpleToken(
        SimpleToken SimpleToken,
        address owner,
        uint256 initialSupply,
        string name,
        string symbol
    );

    /**
     * @dev creates SimpleToken contract
     */
    function createSimpleToken(
        uint256 initialSupply,
        string memory name,
        string memory symbol
    ) public {
        SimpleToken simpleToken = new SimpleToken(
            msg.sender,
            initialSupply,
            name,
            symbol
        );
        tokensOfOwner[msg.sender].push(
            Token(name, "SimpleToken", address(simpleToken))
        );
        emit CreatedSimpleToken(
            simpleToken,
            msg.sender,
            initialSupply,
            name,
            symbol
        );
    }

    /**
     * @dev Returns an array of Tokens for an owner
     */
    function getTokensOfOwner(address owner)
        external
        view
        returns (Token[] memory contracts)
    {
        return tokensOfOwner[owner];
    }
}
