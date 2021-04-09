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


import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721Metadata.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721Enumerable.sol";

import "@openzeppelin/contracts-ethereum-package/contracts/introspection/IERC165.sol";


import "@openzeppelin/contracts-ethereum-package/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

import "@openzeppelin/upgrades/contracts/Initializable.sol";

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
contract TonMinter is Initializable, Ownable {
    
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
     
    using SafeMath for uint256;
    
    address public creolSuper;
    
    /**
     *   __  __           _ _  __ _               
        |  \/  |         | (_)/ _(_)              
        | \  / | ___   __| |_| |_ _  ___ _ __ ___ 
        | |\/| |/ _ \ / _` | |  _| |/ _ \ '__/ __|
        | |  | | (_) | (_| | | | | |  __/ |  \__ \
        |_|  |_|\___/ \__,_|_|_| |_|\___|_|  |___/
        
    */
    modifier onlyCreolSuper(){
        require(msg.sender == creolSuper);
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
 
