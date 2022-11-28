// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity =0.8.4;

import "./interfaces/IUniswapV2ERC20.sol";

//solhint-disable var-name-mixedcase
//solhint-disable reason-string
//solhint-disable const-name-snakecase

contract UniswapV2ERC20 is IUniswapV2ERC20 {
    string public constant override name = "Uniswap V2";
    string public constant override symbol = "UNI-V2";
    uint8 public constant override decimals = 18;
    uint256 public override totalSupply;
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;


    function _mint(address to, uint256 value) internal {
        totalSupply += value;
        balanceOf[to] += value;
        emit Transfer(address(0), to, value);
    }

    function _burn(address from, uint256 value) internal {
        balanceOf[from] -= value;
        totalSupply -= value;
        emit Transfer(from, address(0), value);
    }

    function _approve(
        address owner,
        address spender,
        uint256 value
    ) private {
        allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _transfer(
        address from,
        address to,
        uint256 value
    ) private {
        balanceOf[from] -= value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
    }

    function approve(address spender, uint256 value)
        external
        override
        returns (bool)
    {
        _approve(msg.sender, spender, value);
        return true;
    }
    function increaseApproval(
    address _spender,
    uint _addedValue
    )
    public
    returns (bool)
    {
        allowance[msg.sender][_spender] = (
        allowance[msg.sender][_spender]+_addedValue);
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }
    function decreaseApproval(
        address _spender,
        uint _subtractedValue
    )
    public
    returns (bool)
    {
        uint oldValue = allowance[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
        allowance[msg.sender][_spender] = 0;
        } else {
        allowance[msg.sender][_spender] = oldValue-_subtractedValue;
        }
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }



    function transfer(address to, uint256 value)
        external
        override
        returns (bool)
    {
        _transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override returns (bool) {
        if (allowance[from][msg.sender] != type(uint256).max) {
            allowance[from][msg.sender] -= value;
        }
        _transfer(from, to, value);
        return true;
    }

}
