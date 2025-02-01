// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/**
 * @title BitStateToken
 * @notice Ce contrat déploie le token BTST avec une offre totale fixe de 42 000 000 tokens répartis comme suit :
 *
 * 1. Vente Initiale (20%) : 8 400 000 BTST  
 *    Adresse : 0x299195513c6FB4a2DBad430252b8222CeF266f74
 *
 * 2. Récompenses Communautaires (30%) : 12 600 000 BTST  
 *    Adresse : 0x496e5Ad23FF5DDbddE250F15885FfC7C51cf1Da6
 *
 * 3. Fonds de Développement (15%) : 6 300 000 BTST  
 *    Adresse : 0x4230361f10A284f15dbCBC00f6F7e8f7De3C2730
 *
 * 4. Liquidity Pool (15%) : 6 300 000 BTST  
 *    Adresse : 0x800D2682c6B32DC1f50a50fC5d83bA2ecdA4DC41
 *
 * 5. Équipe & Conseillers (10%) : 4 200 000 BTST  
 *    Adresse : 0x35C6a6528276EbB68D0b5BC8f5419a4110F13527  
 *    (Il est recommandé d'utiliser un contrat de vesting pour cette allocation)
 *
 * 6. Réserve Stratégique (10%) : 4 200 000 BTST  
 *    Adresse : 0xbeE60B922836A1f117836497fAc5a799d5787D04
 *
 * Le contrat utilise ERC20Capped pour garantir qu'aucun token supplémentaire ne puisse être créé.
 */
contract BitStateToken is ERC20Capped, Ownable {
    // Adresses fixes pour chaque allocation
    address public constant saleAddress             = 0x299195513c6FB4a2DBad430252b8222CeF266f74;
    address public constant communityRewardsAddress = 0x496e5Ad23FF5DDbddE250F15885FfC7C51cf1Da6;
    address public constant devFundAddress          = 0x4230361f10A284f15dbCBC00f6F7e8f7De3C2730;
    address public constant liquidityPoolAddress    = 0x800D2682c6B32DC1f50a50fC5d83bA2ecdA4DC41;
    address public constant teamAdvisorAddress      = 0x35C6a6528276EbB68D0b5BC8f5419a4110F13527;
    address public constant reserveAddress          = 0xbeE60B922836A1f117836497fAc5a799d5787D04;

    /**
     * @notice Constructeur du token.
     * Le contrat mintage immédiatement la totalité des 42 000 000 BTST répartis selon la tokenomic définie.
     */
    constructor()
        ERC20("BitState Token", "BTST")
        ERC20Capped(42000000 * 10 ** decimals())
        Ownable(msg.sender) // Transmet msg.sender au constructeur de Ownable
    {
        uint256 totalSupplyWithDecimals = 42000000 * 10 ** decimals();

        // Répartition des tokens selon les pourcentages indiqués
        _mint(saleAddress,             (totalSupplyWithDecimals * 20) / 100); // Vente Initiale : 20%
        _mint(communityRewardsAddress, (totalSupplyWithDecimals * 30) / 100); // Récompenses Communautaires : 30%
        _mint(devFundAddress,          (totalSupplyWithDecimals * 15) / 100); // Fonds de Développement : 15%
        _mint(liquidityPoolAddress,    (totalSupplyWithDecimals * 15) / 100); // Liquidity Pool : 15%
        _mint(teamAdvisorAddress,      (totalSupplyWithDecimals * 10) / 100); // Équipe & Conseillers : 10%
        _mint(reserveAddress,          (totalSupplyWithDecimals * 10) / 100); // Réserve Stratégique : 10%
    }
}
