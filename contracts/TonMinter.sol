/*
  @title TonMinter v0.0.1
 ________  ________  _______   ________  ___          
|\   ____\|\   __  \|\  ___ \ |\   __  \|\  \         
\ \  \___|\ \  \|\  \ \   __/|\ \  \|\  \ \  \        
 \ \  \    \ \   _  _\ \  \_|/_\ \  \\\  \ \  \       
  \ \  \____\ \  \\  \\ \  \_|\ \ \  \\\  \ \  \____  
   \ \_______\ \__\\ _\\ \_______\ \_______\ \_______\
    \|_______|\|__|\|__|\|_______|\|_______|\|_______|
                                             
 
 

  _______          __  __ _       _            
 |__   __|        |  \/  (_)     | |           
    | | ___  _ __ | \  / |_ _ __ | |_ ___ _ __ 
    | |/ _ \| '_ \| |\/| | | '_ \| __/ _ \ '__|
    | | (_) | | | | |  | | | | | | ||  __/ |   
    |_|\___/|_| |_|_|  |_|_|_| |_|\__\___|_|   
                                               
                                               
                        
Author:      Joshua Bijak
Date:        April 09, 2021
Title:       TonMinter Prototype
Description: Contract that accepts signed proofs of a IoT Cookstove and mints an NFT ton when it hits 1000kg
              
  ___                            _       
|_ _|_ __ ___  _ __   ___  _ __| |_ ___ 
 | || '_ ` _ \| '_ \ / _ \| '__| __/ __|
 | || | | | | | |_) | (_) | |  | |_\__ \
|___|_| |_| |_| .__/ \___/|_|   \__|___/
              |_|                       

*/
pragma solidity ^0.8.0;
pragma abicoder v2;



import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "./CarbonVCUInterface.sol";
/*
  _____            _                  _   
 / ____|          | |                | |  
| |     ___  _ __ | |_ _ __ __ _  ___| |_ 
| |    / _ \| '_ \| __| '__/ _` |/ __| __|
| |___| (_) | | | | |_| | | (_| | (__| |_ 
 \_____\___/|_| |_|\__|_|  \__,_|\___|\__|

*/
/**
 * @author Joshua Bijak
 * @title TonMinter
 * @dev  Contract that accepts signed proofs of a IoT Cookstove and mints an NFT ton when it hits 1000kg
 * @notice Prototype Contract that accepts signed proofs of a IoT Cookstove and mints an NFT ton when it hits 1000kg
 * 
 */
contract TonMinter is Initializable, OwnableUpgradeable {
    
    /**
     * 
          ______               _       
         |  ____|             | |      
         | |____   _____ _ __ | |_ ___ 
         |  __\ \ / / _ \ '_ \| __/ __|
         | |___\ V /  __/ | | | |_\__ \
         |______\_/ \___|_| |_|\__|___/
                                       
     * 
     * 
     */
    event newProofSubmitted(uint256 stoveID, uint256 burnTime, uint256 emssionFactor, uint256 gramsCO2e);
    event newPendingCO2eGrams(uint256 pendingCO2eGrams);
    event newStoveID(uint256 stoveID);
    event stoveIDRemoved(uint256 stoveID);
    event newStoveIPFSURI(string stoveURI);
    
        
    /**
     * 
     *    _____ _        _   _          
         / ____| |      | | (_)         
        | (___ | |_ __ _| |_ _  ___ ___ 
         \___ \| __/ _` | __| |/ __/ __|
         ____) | || (_| | |_| | (__\__ \
        |_____/ \__\__,_|\__|_|\___|___/
     * 
     * 
     */
     
    using SafeMathUpgradeable for uint256;
    
    address public creolSuper;
    address public CVCUAddress;
    
    string public cookstoveIPFSURI ="testURI.com";
    
    CarbonVCUInterface public CVCUInterface;
    
    uint256 public pendingCO2eGrams;
    
    struct stoveProof {
        uint256 burnTime;
        uint256 emissionFactor;
        uint256 gramsCO2e;
    }
    
    struct stoveProofs {
        stoveProof[] proofCollection;
    }
    
    
    mapping (uint256 => stoveProofs) private UUIDtoStoveProofs;
    mapping (uint256 => bool) public isValidStoveID;
    
    
    /**
     *   __  __           _ _  __ _               
        |  \/  |         | (_)/ _(_)              
        | \  / | ___   __| |_| |_ _  ___ _ __ ___ 
        | |\/| |/ _ \ / _` | |  _| |/ _ \ '__/ __|
        | |  | | (_) | (_| | | | | |  __/ |  \__ \
        |_|  |_|\___/ \__,_|_|_| |_|\___|_|  |___/
        
    */
    modifier onlyCreolSuper(){
        require(msg.sender == creolSuper, "Not Creol Super");
        _;
    }
    
   
     
     /**
      *   ______                _   _                 
         |  ____|              | | (_)                
         | |__ _   _ _ __   ___| |_ _  ___  _ __  ___ 
         |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
         | |  | |_| | | | | (__| |_| | (_) | | | \__ \
         |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
     */
     
    
     
     constructor () public {
         
     }
     
     function initalizeTonMinter (address _creolSuper, address _CVCU)  public initializer {
         
         OwnableUpgradeable.__Ownable_init();
         creolSuper = _creolSuper;
         CVCUAddress = _CVCU;
         CVCUInterface = CarbonVCUInterface(_CVCU);
         
         
     }
     /**
      * @dev submits a new proof to be tracked by the smart contract on chain, if it hits 1000kg, it triggers a minting on the CVCU contract
      * @param stoveID The IoT Cookstove UUID
      * @param _burnTime Burntime of the stove in seconds
      * @param _emissionFactor Emission Factor used for the calculation
      * @param _gramsCO2e Total Grams calculated for emission reduction
      */
     
     function submitCarbonProof (uint256 stoveID, uint256 _burnTime, uint256 _emissionFactor, uint256 _gramsCO2e) public {
         
         require( isValidStoveID[stoveID], "Not a valid stoveID");
         require( _gramsCO2e > 0, "gramsCO2e cannot be 0");
         require( _burnTime > 0, "Burn time cannot be 0");
         require( _emissionFactor > 0, "emissionFactor cannot be 0");
        
         stoveProof memory _toBeAddedProof;
         _toBeAddedProof.burnTime = _burnTime;
         _toBeAddedProof.emissionFactor = _emissionFactor;
         _toBeAddedProof.gramsCO2e = _gramsCO2e;
         
         UUIDtoStoveProofs[stoveID].proofCollection.push(_toBeAddedProof);
         
         emit newProofSubmitted(stoveID,_burnTime, _emissionFactor, _gramsCO2e);
         
         pendingCO2eGrams = pendingCO2eGrams + _gramsCO2e;
         
         emit newPendingCO2eGrams(pendingCO2eGrams);
         
         
     }
    /**
      * @dev Allows caller to mint CVCUs when there is a threshold amount of CO2e in the contract, they are minted to the defined creolSuper address
      */
     function mintCVCU() public  {
         
         require(pendingCO2eGrams > 1000000, "Not enough pendingCO2eGrams for 1 ton CO2e");
         
         CVCUInterface.mintVCU(creolSuper, cookstoveIPFSURI);
         
         pendingCO2eGrams = pendingCO2eGrams - 1000000;
         
         emit newPendingCO2eGrams(pendingCO2eGrams);
         
         
     }
     
     
     /**
      * @dev Returns the stove proofs for a given stoveID
      * @param stoveID Stove ID to query
      */
     function getProofs(uint256 stoveID) public view returns (stoveProof[] memory _stoveProofs) {
         
         return UUIDtoStoveProofs[stoveID].proofCollection;
         
     }
     /**
      * @dev add an approved stoveID to the contract
      * @param stoveID Unique stoveID number
      */
     function addStoveID (uint256 stoveID) public onlyCreolSuper {
         
         isValidStoveID[stoveID] = true;
         emit newStoveID(stoveID);
     }
     /**
      * @dev remove an approved stoveID to the contract
      * @param stoveID Unique stoveID number
      */
     function removeStoveID(uint256 stoveID) public onlyCreolSuper {
         
         isValidStoveID[stoveID] = false;
         emit stoveIDRemoved(stoveID);
     }
     function setStoveURI(string memory _stoveURI) public onlyCreolSuper {
         
         cookstoveIPFSURI = _stoveURI;
         emit newStoveIPFSURI(cookstoveIPFSURI);
     } 
    

/**
 * 
 * 
 *   _                      _ 
    | |                    | |
    | |     ___  __ _  __ _| |
    | |    / _ \/ _` |/ _` | |
    | |___|  __/ (_| | (_| | |
    |______\___|\__, |\__,_|_|
                 __/ |        
                |___/    
 * 
 * They come with no warranty and are not for use in a production setting. For production usage, please contact joshua.bijak@creol.io
 * 
 */
 }
 
