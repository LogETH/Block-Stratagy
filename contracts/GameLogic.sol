// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract GameLogic {

    //This contract stores game logic, its a contract that stores the game in local memory
    //It can also play multiple games at the same time

    Stat getstats;
    CombatContract combat;
    uint GameIDNonce;

    mapping(address => mapping(address => uint)) Invite;
    mapping(uint => mapping(address => mapping(uint => uint))) Pieces;
    mapping(uint => mapping(address => mapping(uint => mapping(uint => uint)))) LocationX;
    mapping(uint => mapping(address => mapping(uint => mapping(uint => uint)))) LocationY;
    mapping(uint => Map) GameMap;
    mapping(address => bool) ingame;

////Mobile Stats

    mapping(uint => mapping(address => mapping(uint => mapping(uint => uint)))) CurrentHP;

    function InviteOpponent(address Opponent, Map EnterMapAddress, uint Piece1, uint Piece2, uint Piece3, uint Piece4) external{

        Pieces[GameIDNonce][msg.sender][1] = Piece1;
        Pieces[GameIDNonce][msg.sender][2] = Piece2;
        Pieces[GameIDNonce][msg.sender][3] = Piece3;
        Pieces[GameIDNonce][msg.sender][4] = Piece4;

        Invite[msg.sender][Opponent] = GameIDNonce;
        GameMap[GameIDNonce] = EnterMapAddress;
        GameIDNonce += 1;
    }

    function StartGame(uint GameID, uint Piece1, uint Piece2, uint Piece3, uint Piece4) external {

        address Opponent;

        require(Invite[msg.sender][Opponent] == GameIDNonce);

        Pieces[GameID][msg.sender][1] = Piece1;
        Pieces[GameID][msg.sender][2] = Piece2;
        Pieces[GameID][msg.sender][3] = Piece3;
        Pieces[GameID][msg.sender][4] = Piece4;

        ingame[msg.sender] = true;
        ingame[Opponent] = true;
    }

    function PlayTurn(uint GameID, uint PieceID, uint MoveHowManySpacesX, uint MoveHowManySpacesY, bool Attack, uint AttackWhom) external {

        require (Pieces[GameID][msg.sender][1] == PieceID || Pieces[GameID][msg.sender][2] == PieceID || Pieces[GameID][msg.sender][3] == PieceID || Pieces[GameID][msg.sender][4] == PieceID, "That Piece is not currenty being used in the game!");
        


        if(Attack == true){

            uint HP1;
            uint HP2;

            (HP1, HP2) = combat.fight(PieceID, AttackWhom);
        }
    }

    

//////////////////////////////////////////////////////////////////////////////////////////
////                     Internal functions this contract uses                        ////
//////////////////////////////////////////////////////////////////////////////////////////

    function GetGameData(uint GameID, uint DataID) internal {




    }






}

interface CombatContract{

    function fight(uint Piece1, uint Piece2) external returns(uint, uint);
}

interface Map{


}

interface Stat{
    function mov(uint256 PieceID) external returns(uint256);
    function atk(uint256 PieceID) external returns(uint256);
    function def(uint256 PieceID) external returns(uint256);
    function spd(uint256 PieceID) external returns(uint256);
    function maj(uint256 PieceID) external returns(uint256);
    function mhp(uint256 PieceID) external returns(uint256);
}
