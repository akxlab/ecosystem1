// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./ERC2055Storage.sol";

contract ERC2055 is IERC2055 {
    string public name;
    string public symbol;
    uint256 private _totalSupply;
    uint256 private maxSupply;
    address public owner;
    bool private isLocked;
    uint256 private lockedUntil;

    mapping(address => uint256) private _balance;
      mapping(address => mapping(address => uint256)) private _allowances;

    bytes4 private constant TOKEN_INTERFACE_ID =
        bytes4(keccak256(abi.encodePacked("supportedTokenInterfaces(bytes4)")));

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can do this");
        _;
    }

    function setTotalSupply(uint256 supply) public onlyOwner {
        _totalSupply = supply;
    }

    function setMaxSupply(uint256 supply) public onlyOwner {
        maxSupply = supply;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balance[account];
    }

    function transfer(address to, uint256 amount)
        public
        override
        returns (bool)
    {
        this.safeTransferToken(address(this), to, amount);
        return true;
    }



    function approve(address spender, uint256 amount)
        public
        override
        onlyOwner
        returns (bool)
    {
        return _approve(spender, amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
       _transfer(from, to, amount);
       return true;
    }

      /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address _owner = owner;
        _approve(_owner, spender, allowance(_owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address _owner = owner;
        uint256 currentAllowance = allowance(_owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(_owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

  
     function _approve(
        address _owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(_owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[_owner][spender] = amount;
        emit Approval(_owner, spender, amount);
    }

 function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");


        uint256 fromBalance = _balance[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balance[from] = fromBalance - amount;
        }
        _balance[to] += amount;

        emit Transfer(from, to, amount);

     
    }

    function onERC2055Receive() external override {}

    function safeMint(uint256 amount, address to)
        public
     
        onlyOwner
        returns (bool)
    {
        if (amount > maxSupply) {
            revert("amount is higher than the max supply (CAP)");
        }
        if (amount == 0) {
            revert("amount cannot be zero");
        }

        if (_totalSupply == 0) {
            _totalSupply = amount;
        } else {
            _totalSupply += amount;
        }
        if (_balance[to] == 0) {
            _balance[to] = amount;
        } else {
            _balance[to] += amount;
        }
        return true;
    }

    function upgradeERC20ToERC2055(address tokenAddress1)
        external
        override
        returns (IERC2055)
    {}

    function safeBurn(uint256 amount, address to)
        external
        override
        returns (bool)
    {}


    function safeTransferToken(
        address token,
        address receiver,
        uint256 amount
    ) external override returns (bool transferred) {
        // 0xa9059cbb - keccack("transfer(address,uint256)")
        bytes memory data = abi.encodeWithSelector(
            0xa9059cbb,
            receiver,
            amount
        );
        // solhint-disable-next-line no-inline-assembly
        assembly {
            // We write the return value to scratch space.
            // See https://docs.soliditylang.org/en/v0.7.6/internals/layout_in_memory.html#layout-in-memory
            let success := call(
                sub(gas(), 10000),
                token,
                0,
                add(data, 0x20),
                mload(data),
                0,
                0x20
            )
            switch returndatasize()
            case 0 {
                transferred := success
            }
            case 0x20 {
                transferred := iszero(or(iszero(success), iszero(mload(0))))
            }
            default {
                transferred := 0
            }
        }
    }

    function lockToken(uint256 until) public override onlyOwner {
        require(isLocked != true, "already locked");
        isLocked = true;
        lockedUntil = until;
    }

    function unlockToken() public override {
        if (block.timestamp > lockedUntil) {
            revert("cannot unlock");
        }
        isLocked = false;
    }

    function supportedTokenInterfaces(bytes4 interfaceID)
        external
        view
        override
        returns (bool)
    {
        return interfaceID == TOKEN_INTERFACE_ID;
    }

    function safeMint(address tokenAddress, address to)
        external
        override
        returns (bool)
    {}
}
