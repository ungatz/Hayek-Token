pragma solidity ^0.5.16;

import "./ERC20.sol"

contract HYK is ERC20 {
    string public name = "Hayek Token";
    string public symbol = "HYK";
    uint8 public decimal = 18; // Setting decimals to 18 to match with Wei distribution.
}
