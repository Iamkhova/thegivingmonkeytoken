// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.2;

import "./interfaces/IERC20Interface.sol";
import "./lib/SafeMathLibrary.sol";
import "./lib/AddressLibrary.sol";
import "./access/Ownable.sol";


contract TheGivingMonkey is Context, IERC20, Ownable {
    using SafeMath for uint256;
    using Address for address;

    
    mapping(address => uint256) private _reflectionOwned;
    mapping(address => uint256) private _tokenOwned;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;


    uint256 private constant MAX = ~uint256(0);
    uint256 private _tokenSupply = 1000000 * 10**18;
    uint256 private _reflectionTotal = (MAX - (MAX % _tokenSupply));
    uint256 private _tokenFeeTotal;

    string private _name = 'The Giving Monkey Token';
    string private _symbol = 'MONKEY';
    uint8 private _decimals = 18;


   // uint public totalSupply = 1000000 * 10**18;
    //string public name = "The Giving Monkey Token";
   // string public symbol = "MCARES";
  //  uint public decimals = 18;

    //event Transfer(address indexed from, address indexed to, uint value);
    //event Approval(address indexed owner, address indexed spender, uint value);

    constructor() {
        _balances[msg.sender] = _tokenSupply; //Send balance of tokens to creator of smart address
    }

    // The allowance() function returns the token amount remaining, which the spender is currently allowed to withdraw from the owner's account. 
    function allowance(address owner, address spender) public view override returns (uint256) {
            return _allowances[owner][spender];
        }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }


    function totalSupply() public view override returns (uint256) {
            return _tokenSupply;
    }

////


    function balanceOf(address owner) public view returns(uint) {
        return _balances[owner];
    }

    function transfer(address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'balance too low');
        _balances[to] += value;
        _balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'balance too low');
        require(_allowances[from][msg.sender] >= value, 'allowance too low');
        _balances[to] +=value;
        _balances[from] -=value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint value) public returns(bool) {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

}