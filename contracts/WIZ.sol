pragma solidity >=0.7.0 <0.9.0;

import "./ERC20.sol"

contract WHIZ is ERC20 {
    string public name = "WHIZ Token";
    string public symbol = "WIZ";
    uint8 public decimal = 18; // Setting decimals to 18 to match with Wei distribution.
}
