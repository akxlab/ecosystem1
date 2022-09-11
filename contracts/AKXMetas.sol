// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract AKXMetas {
    struct AKXMetaStorage {
        string name;
        string[] symbols;
        string logoURI;
        string[] socialURIs;
        string websiteURI;
        string whitePaperURI;
        string contactEmail;
        string version;
        address[] founders;
        address deployer;
        uint256 deployedOn;
        uint256 lastUpdate;
        uint256 totalTokenValue;
        uint256 numAccounts;
        uint256 chainId;
    }

    bytes4 AKXMETAS_STORAGE_ID = bytes4(keccak256('akx.ecosystem.metas.storage'));


    function metaStorage()
    internal
    pure
    returns (AKXMetaStorage storage akxmetas)
    {
        assembly {
            akxmetas.slot := AKXMETAS_STORAGE_ID.slot
        }
    }

    function setName(string memory __name) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.name = __name;
    }

    function setSymbols(string[] memory __symbols) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.symbols = __symbols;
    }

    function setLogoURI(string memory __logo) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.logoURI = __logo;
    }

    function setSocialURIs(string[] memory __socials) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.socialURIs = __socials;
    }

    function setWebsiteURI(
        string memory __www,
        string memory __wpu,
        string memory __contactemail
    ) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.websiteURI = __www;
        akxmetas.whitePaperURI = __wpu;
        akxmetas.contactEmail = __contactemail;
    }

    function setVersion(string memory __ver) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.version = __ver;
    }

    function setFounders(address[] memory __f) internal {
        AKXMetaStorage storage akxmetas = metaStorage();
        akxmetas.founders = __f;
    }

    function getName() external view returns (string memory) {
        AKXMetaStorage storage akxmetas = metaStorage();
        return akxmetas.name;
    }

    function getVersion() external view returns (string memory) {
        AKXMetaStorage storage akxmetas = metaStorage();
        return akxmetas.version;
    }

    function getFounders() external view returns (address[] memory) {
        AKXMetaStorage storage akxmetas = metaStorage();
        return akxmetas.founders;
    }
}