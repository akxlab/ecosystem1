// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "../tokens/ERC2055/ERC2055Wrapper.sol";
import "../Roles.sol";

contract LABZ is
    Initializable,
    UUPSUpgradeable,
    AccessControlEnumerableUpgradeable,
    ERC2055Wrapper,
    AKXRoles
{
    constructor() {
        _disableInitializers();
    }

    function initialize(address implementation, address _dao)
        public
        initializer
    {
        __AccessControlEnumerable_init();
        __ERC2055Wrapper_init(implementation);
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(DAO_ROLE, _dao);
        _grantRole(DAO_ROLE, _dao);
        _grantRole(DAO_ROLE, msg.sender); // in case of a verrry big problem and an emergency upgrade is needed.
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        virtual
        override
        onlyRole(DAO_ROLE)
    {}

    function safeMint(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool minted) {}

    function safeBurn(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool burned) {}

    function safeTransferToken(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool transferred) {}

    function totalSupply() external view override returns (uint256) {}

    function balanceOf(address account)
        external
        view
        override
        returns (uint256)
    {}

    function allowance(address owner, address spender)
        external
        view
        override
        returns (uint256)
    {}

    function approve(address spender, uint256 amount)
        external
        override
        returns (bool)
    {}

    function name() external override returns (string memory) {}

    function symbol() external override returns (string memory) {}

    function decimals() external override returns (uint8) {}

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override {}

    function nonces(address owner) external view override returns (uint256) {}

    function DOMAIN_SEPARATOR() external view override returns (bytes32) {}

    function lockToken(uint256 until, uint256 amount) external override {}

    function unlockToken() external override {}

    function setBuyLogic(address _buyLogicContract) external override {}

    function setSellLogic(address _sellLogicContract) external override {}

    function buy() external payable override returns (bool success) {}

    function setWithdrawRecipient(address _recipientContract)
        external
        override
    {}
}