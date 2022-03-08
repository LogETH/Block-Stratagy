// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Stats {

    //This contract stores stats of pieces
    //It also establishes a very easy syntax to get stats
    //getstats.atk(pieceID) is all you have to do to get the stats

    address Router = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;

//// Variables that store the base stat values of every piece except HP

    mapping(uint => uint) ATK;
    mapping(uint => uint) SPD;
    mapping(uint => uint) DEF;
    mapping(uint => uint) MAG;
    mapping(uint => uint) MOV;
    mapping(uint => uint) MHP;

//// Functions that display the stats

    function mov(uint256 PieceID) external view returns(uint256){

        return MOV[PieceID];
    }
    function atk(uint256 PieceID) external view returns(uint256){

        return ATK[PieceID];
    }
    function def(uint256 PieceID) external view returns(uint256){
 
        return DEF[PieceID];
    }
    function spd(uint256 PieceID) external view returns(uint256){

        return SPD[PieceID];
    }
    function maj(uint256 PieceID) external view returns(uint256){

        return MAG[PieceID];
    }
    function mhp(uint256 PieceID) external view returns(uint256){

        return MHP[PieceID];
    }

//// These are functions that edit stats, they are not meant to be called normally

    function EditStats(uint PieceID) internal {

        require(tx.origin = Router);

    }

}
