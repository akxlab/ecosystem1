// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../../interfaces/IEIP-1155U.sol";
import "../../interfaces/IEIP-1155UResolver.sol";
import "../../interfaces/IEIP1155UMetadataURI.sol";
import "../../interfaces/IEIP-1155UReceiver.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Context.sol";


contract EIP1155U is Context, ERC165, IEIP1155U, IEIP1155UMetadataURI {
    using Address for address;

    // Mapping from account to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // Used as the URI for all token types by relying on ID substitution, e.g. https://token-cdn-domain/{id}.json
    string private _uri;

    address public resolverAddress;

    constructor(address _resolverAddr, string memory uri_) {
        resolverAddress = _resolverAddr;
        _setURI(uri_);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC165)
        returns (bool)
    {
        return
            interfaceId == type(IEIP1155U).interfaceId ||
            interfaceId == type(IEIP1155UMetadataURI).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     *
     * This implementation returns the same URI for *all* token types. It relies
     * on the token type ID substitution mechanism
     * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
     *
     * Clients calling this function must replace the `\{id\}` substring with the
     * actual token type ID.
     */
    function uri(uint256) public view virtual override returns (string memory) {
        return _uri;
    }

    function _setURI(string memory newuri) internal virtual {
        _uri = newuri;
    }

    function _mint(
        address to,
        uint256 id,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");

        address operator = _msgSender();

        emit TransferSingle(operator, address(0), to, id);

        _doSafeTransferAcceptanceCheck(operator, address(0), to, id, data);
    }

    function _burn(address from, uint256 id) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");

        address operator = _msgSender();
      

        emit TransferSingle(operator, from, address(0), id);
    }

    function _setApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) internal virtual {
        require(owner != operator, "ERC1155: setting approval status for self");
        _operatorApprovals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved)
        public
        virtual
        override
    {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC1155-isApprovedForAll}.
     */
    function isApprovedForAll(address account, address operator)
        public
        view
        virtual
        override
        returns (bool)
    {
        return _operatorApprovals[account][operator];
    }

    /**
     * @dev See {IERC1155-safeTransferFrom}.
     */
        function safeTransferFrom(address _from, address _to, uint256 id, bytes memory _data) public virtual override
 {
        require(
            _from == _msgSender() || isApprovedForAll(_from, _msgSender()),
            "ERC1155: caller is not token owner nor approved"
        );
        _safeTransferFrom(_from, _to, id, _data);
    }

    /**
     * @dev See {IERC1155-safeBatchTransferFrom}.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        bytes calldata data
    ) public virtual override {
        require(
            from == _msgSender() || isApprovedForAll(from, _msgSender()),
            "ERC1155: caller is not token owner nor approved"
        );
        _safeBatchTransferFrom(from, to, ids, data);
    }

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function _safeTransferFrom(
        address from,
        address to,
        uint256 id,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: transfer to the zero address");

        address operator = _msgSender();

        emit TransferSingle(operator, from, to, id);


        _doSafeTransferAcceptanceCheck(operator, from, to, id,  data);
    }

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function _safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERCU1155: transfer to the zero address");

        address operator = _msgSender();

        emit TransferBatch(operator, from, to, ids);
    }


   
    function mint(address _to) external override returns (uint256) {}

    function burn(address _from, address _to)
        external
        override
        returns (uint256)
    {}

    function recover(address _from, bytes calldata _recoveryData)
        external
        override
        returns (bool)
    {}

    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,

        bytes memory data
    ) private {
        if (to.isContract()) {
            try
                IEIP1155UReceiver(to).onEIP1155UReceived(
                    operator,
                    from,
                    keccak256(abi.encodePacked(id)),
                    data
                )
            returns (bytes4 response) {
                if (response != IEIP1155UReceiver.onEIP1155UReceived.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non ERC1155Receiver implementer");
            }
        }
    }

    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        bytes32[] memory ids,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try
                IEIP1155UReceiver(to).onEIP1155UBatchReceived(
                    operator,
                    from,
                    ids,
                    data
                )
            returns (bytes4 response) {
                if (
                    response !=
                    IEIP1155UReceiver.onEIP1155UBatchReceived.selector
                ) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non ERC1155Receiver implementer");
            }
        }
    }

    function _asSingletonArray(uint256 element)
        private
        pure
        returns (uint256[] memory)
    {
        uint256[] memory array = new uint256[](1);
        array[0] = element;

        return array;
    }

   

    function balanceOf(address _owner, uint256 _id) external override {}
}