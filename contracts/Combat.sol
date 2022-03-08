// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract combat {

    //This contract stores combat logic, nothing else. It is called whenever there is combat.

    Stat getstats;

    function fight(uint Piece1, uint Piece2) external returns (uint){

        uint Damage;
        uint HP1;
        uint HP2;

        
        Damage = getstats.atk(Piece1) - getstats.def(Piece2);


    }
}



interface Stat{
    function mov(uint256 PieceID) external returns(uint256);
    function atk(uint256 PieceID) external returns(uint256);
    function def(uint256 PieceID) external returns(uint256);
    function spd(uint256 PieceID) external returns(uint256);
    function maj(uint256 PieceID) external returns(uint256);
    function mhp(uint256 PieceID) external returns(uint256);
}
