// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GardenContract is ERC721URIStorage, Ownable {
    enum GardenSize { Small, Medium, Large }
    enum GardenType { One, Two, All, Learn }

    struct Garden {
        uint256 gardenID;
        address owner;
        GardenSize size;
        GardenType gardenType;
    }

    struct Plant {
        uint256 plantID;
        uint256 mintingDate;
        bool isFruiting;
        string metadataURI;
    }

    mapping(uint256 => Garden) public gardens;
    mapping(uint256 => Plant) public plants;
    uint256 public plantCounter;

    event GardenRegistered(uint256 indexed gardenID, address owner, GardenSize size, GardenType gardenType);
    event PlantAdded(uint256 indexed gardenID, uint256 indexed plantID, string metadataURI);

    // Updated constructor to pass the name and symbol to ERC721
    constructor() ERC721("OlinkPlants", "OLKP") Ownable(msg.sender) {}

    function registerGarden(uint256 _gardenID, GardenSize _size, GardenType _gardenType) public {
        gardens[_gardenID] = Garden(_gardenID, msg.sender, _size, _gardenType);
        emit GardenRegistered(_gardenID, msg.sender, _size, _gardenType);
    }

    function addPlant(uint256 _gardenID, string memory _metadataURI) public {
        uint256 newPlantID = ++plantCounter;
        plants[newPlantID] = Plant(newPlantID, block.timestamp, false, _metadataURI);
        _mint(msg.sender, newPlantID);
        _setTokenURI(newPlantID, _metadataURI);
        emit PlantAdded(_gardenID, newPlantID, _metadataURI);
    }

    function updatePlantMetadata(uint256 _plantID, string memory _newMetadataURI, bool _isFruiting) public {
        plants[_plantID].metadataURI = _newMetadataURI;
        plants[_plantID].isFruiting = _isFruiting;
        _setTokenURI(_plantID, _newMetadataURI);
    }
}
