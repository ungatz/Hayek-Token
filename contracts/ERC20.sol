pragma solidity ^0.5.16;
import "./ERC20I.sol";

contract ERC20 is ERC20I {
		// Using a hash table to store all balances as
		// also because using hash table is cheaper interms of gas than expensive array operations.
		mapping (address => uint256) private _balances;
		
		// Mapping the allowances.
		mapping (address => mapping (address => uint256)) private _allowances;

		uint256 private _totalSupply;

		function totalSupply() public view returns (uint256){
				return _totalSupply;
		}

		// Now we implement the ERC20 Standard mandatory functions.
		function allowance(address owner, address spender) public view returns (uint256) {
				return _allowances[owner][spender];
		}

		function transfer(address recipient, uint256 amount) public returns (bool) {
				_transfer(msg.sender, recipient, amount);
				return true;
		}

		function approve(address spender, uint256 amount) public returns (bool) {
				_approve(msg.sender, spender, amount);
		}

		function balanceOf(address account) public view returns (uint256) {
		    return _balances[account];
		}

		function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
				_transfer(sender, recipient, amount);
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
		function _mint(address account, uint256 amount) internal {
				require(account != address(0), "Can't mint to 0 address");
				_totalSupply += amount;
				_balances[account] += amount;
				emit Transfer(address(0), account, amount);
		}

		function _burn(address account, uint256 amount) internal {
			require(account != address(0), "ERC20: burn from the zero address");

			uint256 accountBalance = _balances[account];
			require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
			_balances[account] = accountBalance - amount;
			_totalSupply -= amount;

			emit Transfer(account, address(0), amount);
		}

		function _approve(address owner, address spender, uint256 amount) internal {
				require(owner != address(0), "Can't approve from 0 address");
				require(spender != address(0), "Can't approve to 0 address");
				_allowances[owner][spender] = amount;
				emit Approval(owner, spender, amount);
		}

		function burnFrom(address account, uint256 value) public {
			_burn(account, value);
			_approve(account, msg.sender, _allowances[account][msg.sender] - value);
		}
}
