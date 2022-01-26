// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract JuanitoTokenContract is IERC20 {

    mapping(address => uint) private balances;
    mapping(address => mapping(address => uint)) private allowed;
    uint256 private _totalSupply;
    address owner;

    constructor(uint256 totalTokens) {
        _totalSupply = totalTokens;
        balances[msg.sender] = totalTokens;
        owner = msg.sender;
    }

    function name() external override pure returns (string memory){
        return "ERC20JuanitoToken";
    }

    function symbol() external override pure returns (string memory){
        return "JUTK";
    }

    function decimals() external override pure returns (uint8){
        return 18;
    }

    function totalSupply() external override view returns (uint256){
        return _totalSupply;
    }

    function increaseTotalSupply(uint newTokensAmount) external {
        require(owner == msg.sender, "Only owner can increase the supply");
        balances[msg.sender] += newTokensAmount;
        _totalSupply += newTokensAmount;
    }

    function balanceOf(address _owner) external override view returns (uint256 balance){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) external override returns (bool success){
        require(balances[msg.sender] >= _value, "Not enough tokens");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external override returns (bool success){
        require(allowed[_from][msg.sender] >= _value, "Not allowed to perform this action");
        require(balances[_from] >= _value, "Owner does not have enough tokens");

        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // Watch out, there is a vulnerability with this https://users.encs.concordia.ca/~clark/papers/2019_sb_erc20.pdf
    function approve(address _spender, uint256 _value) external override returns (bool success){
        require(balances[msg.sender] >= _value, "Owner does not have enough tokens");
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) external override view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
}
