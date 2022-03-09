// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract GameLogic {

    //This contract stores game logic, its a contract that stores the game in local memory
    //It can also play multiple games at the same time

    Stat getstats;
    CombatContract combat;
    Movement move;
    uint GameIDNonce;

////Nested mappings are bruh, like, very bruh

    mapping(address => mapping(address => uint)) Invite;
    mapping(uint => mapping(address => mapping(uint => uint))) Pieces;
    mapping(uint => mapping(address => mapping(uint => uint))) LocationX;
    mapping(uint => mapping(address => mapping(uint => uint))) LocationY;
    mapping(uint => mapping(address => mapping(uint => bool))) Dead;
    mapping(uint => Map) GameMap;
    mapping(address => bool) ingame;

////Mobile Stats

    mapping(uint => mapping(address => mapping(uint => uint))) CurrentHP;

////and the code

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

//// Dev notes: AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

    function PlayTurn(uint GameID, uint PieceID, uint MoveHowManySpacesX, uint MoveHowManySpacesY, bool Attack, uint AttackWhom) external {

        require (Pieces[GameID][msg.sender][1] == PieceID || Pieces[GameID][msg.sender][2] == PieceID || Pieces[GameID][msg.sender][3] == PieceID || Pieces[GameID][msg.sender][4] == PieceID, "That Piece is not currently being used in the game!");
        require (GameID < (GameIDNonce - 1), "That game doesn't even exist yet you idiot!");
        require (Dead[GameID][msg.sender][PieceID] = false, "You can't move a dead piece.");
        
        (LocationX[GameID][msg.sender][PieceID], LocationY[GameID][msg.sender][PieceID]) = move.MovePiece(PieceID, MoveHowManySpacesX, MoveHowManySpacesY);

        if(Attack == true){

            require(move.getdistance(LocationX[GameID][msg.sender][PieceID],LocationY[GameID][msg.sender][PieceID],LocationX[GameID][msg.sender][AttackWhom],LocationY[GameID][msg.sender][AttackWhom]) == getstats.range(PieceID));

            (CurrentHP[GameID][msg.sender][PieceID], CurrentHP[GameID][msg.sender][AttackWhom]) = combat.fight(PieceID, AttackWhom);

            if(CurrentHP[GameID][msg.sender][PieceID] == 0){

                Dead[GameID][msg.sender][PieceID] = true;
            }

            if(CurrentHP[GameID][msg.sender][AttackWhom] == 0){

                Dead[GameID][msg.sender][AttackWhom] = true;
            }
        }
    }

    

//////////////////////////////////////////////////////////////////////////////////////////
////                     Internal functions this contract uses                        ////
//////////////////////////////////////////////////////////////////////////////////////////

    function GetLocation(uint GameID, uint DataID) internal {




    }






}

interface Movement{

    function MovePiece(uint, uint, uint) external returns(uint,uint);
    function getdistance(uint, uint, uint, uint) external returns (uint);
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
    function range(uint PieceID) external returns(uint256);
}
