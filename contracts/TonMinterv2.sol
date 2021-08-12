/*
  @title TonMinter v0.2.0
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
Title:       TonMinter v2 Prototype
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

import "./TonMinter.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

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
 * @title TonMinterv2
 * @dev  Contract that accepts signed proofs of a IoT Cookstove and mints an NFT ton when it hits 1000kg
 * @notice Prototype Contract that accepts signed proofs of a IoT Cookstove and mints an NFT ton when it hits 1000kg
 *
 */
contract TonMinter_v2 is TonMinter {


    event newProofSubmitted_v2(string stoveID, uint256 burnTime, uint256 emssionFactor, uint256 gramsCO2e, uint256 stoveGroupID);
    event newStoveID_v2(string stoveID);

    using SafeMathUpgradeable for uint256;

    struct stoveProof_v2 {
        uint256 burnTime;
        uint256 emissionFactor;
        uint256 gramsCO2e;
        uint256 stoveGroupID;
    }

    struct stoveProofs_v2 {
        stoveProof_v2[] proofCollection;
    }

    struct stoveGroupProofs_v2 {
        uint256 pendingCO2eGrams;
    }

    mapping (uint256 => stoveGroupProofs_v2) private stoveGroupIDtoPendingCO2eGrams_v2;

    mapping (string => stoveProofs_v2) private UUIDtoStoveProofs_v2;

    mapping (string => bool) public isValidStoveID_v2;

     constructor () {

     }

     /**
      * @dev submits a new proof to be tracked by the smart contract on chain, if it hits 1000kg, it triggers a minting on the CVCU contract
      * @param stoveID The IoT Cookstove UUID
      * @param _burnTime Burntime of the stove in seconds
      * @param _emissionFactor Emission Factor used for the calculation
      * @param _gramsCO2e Total Grams calculated for emission reduction
      * @param _stoveGroupID GroupID of stoves 
      */

     function submitCarbonProof_v2 (string memory stoveID, uint256 _burnTime, uint256 _emissionFactor, uint256 _gramsCO2e, uint256 _stoveGroupID) public {

         require( isValidStoveID_v2[stoveID], "Not a valid stoveID");
         require( _gramsCO2e > 0, "gramsCO2e cannot be 0");
         require( _burnTime > 0, "Burn time cannot be 0");
         require( _emissionFactor > 0, "emissionFactor cannot be 0");

         stoveProof_v2 memory _toBeAddedProof;
         _toBeAddedProof.burnTime = _burnTime;
         _toBeAddedProof.emissionFactor = _emissionFactor;
         _toBeAddedProof.gramsCO2e = _gramsCO2e;
         _toBeAddedProof.stoveGroupID = _stoveGroupID;

         UUIDtoStoveProofs_v2[stoveID].proofCollection.push(_toBeAddedProof);

         emit newProofSubmitted_v2(stoveID,_burnTime, _emissionFactor, _gramsCO2e, _stoveGroupID);
         
         stoveGroupIDtoPendingCO2eGrams_v2[_stoveGroupID].pendingCO2eGrams = stoveGroupIDtoPendingCO2eGrams_v2[_stoveGroupID].pendingCO2eGrams.add(_gramsCO2e);

         emit newPendingCO2eGrams(stoveGroupIDtoPendingCO2eGrams_v2[_stoveGroupID].pendingCO2eGrams, _stoveGroupID);


     }
    /**
* @dev add an approved stoveID to the contract
* @param stoveID Unique stoveID number
*/
    function addStoveID_v2 (string memory stoveID) public onlyCreolSuper {

        isValidStoveID_v2[stoveID] = true;
        emit newStoveID_v2(stoveID);
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