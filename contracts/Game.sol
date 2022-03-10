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
    mapping(uint => mapping(address => mapping(uint => int))) LocationX;
    mapping(uint => mapping(address => mapping(uint => int))) LocationY;
    mapping(uint => mapping(address => mapping(uint => bool))) Dead;
    
    mapping(uint => mapping(bool => address)) WhoIsInTheGame;
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

        WhoIsInTheGame[GameIDNonce][true] = msg.sender;

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

        WhoIsInTheGame[GameID][false] = msg.sender;

        ingame[msg.sender] = true;
        ingame[Opponent] = true;
    }

//// Dev notes: AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

    function PlayTurn(uint GameID, uint PieceID, int MoveHowManySpacesX, int MoveHowManySpacesY, bool Attack, uint AttackWhom) external {

        require (Pieces[GameID][msg.sender][1] == PieceID || Pieces[GameID][msg.sender][2] == PieceID || Pieces[GameID][msg.sender][3] == PieceID || Pieces[GameID][msg.sender][4] == PieceID, "That Piece is not currently being used in the game!");
        require (GameID < (GameIDNonce - 1), "That game doesn't even exist yet you idiot!");
        require (Dead[GameID][msg.sender][PieceID] = false, "You can't move a dead piece... its dead");
        require(msg.sender == WhoIsInTheGame[GameID][true] || msg.sender == WhoIsInTheGame[GameID][false]);
        
        (LocationX[GameID][msg.sender][PieceID], LocationY[GameID][msg.sender][PieceID]) = move.MovePiece(PieceID, MoveHowManySpacesX, MoveHowManySpacesY);

        if(Attack == true){

            require(move.getdistance(LocationX[GameID][msg.sender][PieceID],LocationY[GameID][msg.sender][PieceID],LocationX[GameID][this.getplayer(GameID, msg.sender)][AttackWhom],LocationY[GameID][this.getplayer(GameID, msg.sender)][AttackWhom]) == getstats.range(PieceID));

            (CurrentHP[GameID][msg.sender][PieceID], CurrentHP[GameID][this.getplayer(GameID, msg.sender)][AttackWhom]) = combat.fight(GameID, msg.sender, this.getplayer(GameID, msg.sender), PieceID, AttackWhom);

            if(CurrentHP[GameID][msg.sender][PieceID] == 0){

                Dead[GameID][msg.sender][PieceID] = true;
            }

            if(CurrentHP[GameID][this.getplayer(GameID, msg.sender)][AttackWhom] == 0){

                Dead[GameID][this.getplayer(GameID, msg.sender)][AttackWhom] = true;
            }
        }
    }

//// Dev notes: Using a funcation command in a nested mapping as a variable inside a nested mapping is fun

    function Win(uint GameID) external {

        require(Dead[GameID][this.getplayer(GameID, msg.sender)][Pieces[GameID][this.getplayer(GameID, msg.sender)][1]] == true);
        require(Dead[GameID][this.getplayer(GameID, msg.sender)][Pieces[GameID][this.getplayer(GameID, msg.sender)][2]] == true);
        require(Dead[GameID][this.getplayer(GameID, msg.sender)][Pieces[GameID][this.getplayer(GameID, msg.sender)][3]] == true);
        require(Dead[GameID][this.getplayer(GameID, msg.sender)][Pieces[GameID][this.getplayer(GameID, msg.sender)][4]] == true);

    }

    
    

//////////////////////////////////////////////////////////////////////////////////////////
////                     Internal functions this contract uses                        ////
//////////////////////////////////////////////////////////////////////////////////////////

    function hp(uint GameID, address Who, uint PieceID) external view returns (uint) {

        return CurrentHP[GameID][Who][PieceID];

    }

/// This function tells you who your opponent is, in case you forgot

    function getplayer(uint GameID, address Player) external view returns (address){

        require(Player == WhoIsInTheGame[GameID][true] || Player == WhoIsInTheGame[GameID][false]);

        if(WhoIsInTheGame[GameID][false] == Player){

            return WhoIsInTheGame[GameID][true];
        }
        if(WhoIsInTheGame[GameID][true] == Player){

            return WhoIsInTheGame[GameID][false];
        }

    }






}

interface Movement{

    function MovePiece(uint, int, int) external returns(int,int);
    function getdistance(int, int, int, int) external returns (uint);
}

interface CombatContract{

    function fight(uint GameID, address initiator, address defender, uint Piece1, uint Piece2) external returns(uint, uint);
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