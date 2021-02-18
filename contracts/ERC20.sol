pragma solidity >=0.7.0 <0.9.0;

import "./ERC20I.sol";

contract ERC20 is ERC20I {
		// Using a hash table to store all balances as
		// also because using hash table is cheaper interms of gas than expensive array operations.
		mapping (address => uint256) private _balances;
		
		// Mapping the allowances.
		mapping (address => mapping (address => uint256)) private _allowances;

		string private _name;
		string private _symbol;
		uint256 private totalSupply;

		// As contructor is called only once (sabse pehli bar jab EVM pe execute hota hai tab)
		// So  we'll use it to set Name and Symbol.
		constructor (string memory name, string memory symbol){
				_name = name;
				_symbol = symbol;
		}

		// Returns name of the token.
		function getName() public view returns (string memory){
				return _name;
		}

		// Returns Symbol of the token.
		function getSymbol() public view returns (string memory){
				return _symbol;
		}

		fuction getTotalSupply() public view override returns (uint256){
				return totalSupply;
		}

		// Now we implement the ERC20 Standard mandatory functions.
		function allowance(address owner, address spender) public view override returns (uint256) {
				return _allowances[owner][spender];
		}

		function transfer(address recipient, uint256 amount) public returns (bool) {
				_transfer(msg.sender, recipient, amount);
				return true;
		}

		function approve(address sender, uint256 amount) public override returns (bool) {
				_approve(msg.sender, spender, amount);
		}

		function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
				_transfer(sender, reicipient, amount);
				uint256 currentAllowance = _allowances[sender][msg.sender];
				require(currentAllowance >= amount, "Transfer exceeds allowance");
				_approve(sender, msg.sender, currentAllowance - amount);
				return true;
		}

		function _transfer(address sender, address reciever, uint256 amount) internal {
				require(sender != address(0), "Can't transfer from 0 address");
				require(reciever != address(0), "Can't tansfer to 0 address");
				uint256 senderBalance = _balances[sender];
				require(senderBalance >= amount, "Not enough balance!");
				_balances[sender] = senderBalance - amount;
				_balances[reciever] += amount;
			 
				emit Transfer(sender, reciever, amount);
		}

		// Creates "amount" of tokens and adds them to "account" thus increasing
		// the total supply.
		function _mint(address account, uint256 amount) internal virtual {
				require(account != address(0), "Can't mint to 0 address");
				totalSupply += amount;
				_balances[account] += amount;
				emit Transfer(address(0), account, amount);
		}

		function _approve(address owner, address spender, uint256 amount) internal virtual {
				require(owner != address(0), "Can't approve from 0 address");
				require(spender != address(0), "Can't approve to 0 address");
				_allowances[owner][spender] = amount;
				emit Approval(owner, spender, amount);
		}
		
}
