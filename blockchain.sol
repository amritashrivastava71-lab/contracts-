// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Blockchain for Ethical Sourcing Verification
 * @dev This contract allows manufacturers and suppliers to record and verify
 *      ethically sourced materials using blockchain transparency.
 */

contract Project {
    // Structure to store supplier information
    struct Supplier {
        string name;
        string location;
        bool isCertified;
    }

    // Mapping of supplier addresses to their details
    mapping(address => Supplier) public suppliers;

    // Event emitted when a supplier is registered
    event SupplierRegistered(address supplierAddress, string name, string location);

    // Event emitted when certification status changes
    event CertificationUpdated(address supplierAddress, bool isCertified);

    // Function to register a new supplier
    function registerSupplier(string memory _name, string memory _location) public {
        require(bytes(_name).length > 0, "Supplier name required");
        require(bytes(_location).length > 0, "Supplier location required");
        require(bytes(suppliers[msg.sender].name).length == 0, "Supplier already registered");

        suppliers[msg.sender] = Supplier({
            name: _name,
            location: _location,
            isCertified: false
        });

        emit SupplierRegistered(msg.sender, _name, _location);
    }

    // Function to update ethical certification (only supplier themselves)
    function updateCertificationStatus(bool _status) public {
        require(bytes(suppliers[msg.sender].name).length != 0, "Supplier not registered");

        suppliers[msg.sender].isCertified = _status;
        emit CertificationUpdated(msg.sender, _status);
    }

    // Function to verify supplier details
    function verifySupplier(address _supplier) public view returns (string memory, string memory, bool) {
        Supplier memory s = suppliers[_supplier];
        return (s.name, s.location, s.isCertified);
    }
}

