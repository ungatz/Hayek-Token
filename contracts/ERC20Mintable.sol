pragma solidity >=0.4.21 <0.6.0;

import "./ERC20.sol";
import "../access/roles/MinterRole.sol";

contract ERC20Mintable is ERC20, MinterRole {

    function mint(address to, uint256 value) public onlyMinter returns (bool) {
        _mint(to, value);
        return true;
    }
}
