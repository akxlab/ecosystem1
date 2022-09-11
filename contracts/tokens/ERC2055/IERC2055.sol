// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;



interface IERC2055 {

    /**
  * @dev Emitted when a quantity (amount) of token is locked

     */

    event LockedToken(address from, uint256 fromTime, uint256 duration, uint256 amount);

    /**
* @dev Emitted when a quantity (amount) of token is unlocked

     */

    event UnlockedToken(address from, uint256 unlockedTime, uint256 amount);


    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferToken(address from, address to, uint256 amount) external returns(bool transferred);



    // ------ IERC20 ----- //

    /**
    * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.

    *   Changes: DISABLED - as it will use the SafeTransferToken function instead
     */
    //function transfer(address to, uint256 amount) internal returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     * Changes: DISABLED - as it will use the SafeTransferToken function instead
     */
    // function transferFrom(
    //    address from,
    //    address to,
    //    uint256 amount
    //) internal returns (bool);

    // -----------------------IERC2055 METAS------------------------- //

    /**
    * @dev Returns the name of the token.
     */
    function name() external returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external returns (uint8);

    /**
    * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);


    // ---------------------- IERC2055 ONLY RELATED FUNCTIONS ----------------------- //


    /**
     * @dev locks a set amount of token for the specified duratrion
     *
     *
     * Emits a {LockedToken} event.
     */
    function lockToken(uint256 until, uint256 amount) external;


    /**
   * @dev unlocks a set amount of token
     *
     *
     * Emits a {UnlockedToken} event.
     */

    function unlockToken() external;

    function safeMint(address from, address to, uint256 amount) external returns(bool minted);
    function safeBurn(address from, address to, uint256 amount) external returns(bool burned);

    function setBuyLogic(address _buyLogicContract) external;
    function setSellLogic(address _sellLogicContract) external;
    function buy() external payable returns(bool success);

    function setWithdrawRecipient(address _recipientContract) external;




}