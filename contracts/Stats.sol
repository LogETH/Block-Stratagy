// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Stats {

    //This contract stores stats of pieces
    //It also establishes a very easy syntax to get stats
    //getstats.atk(pieceID) is all you have to do to get the stats

    address Router = 0xC65423A320916d7DAF86341De6278d02c7E1D3B1;

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

        require(msg.sender == Router);

        

    }

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    mapping (uint256 => address) private _tokenOwner;
    mapping (uint256 => address) private _tokenApprovals;
    mapping (address => mapping (address => bool)) private _operatorApprovals;


    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "ERC721: approve to caller");

        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "ERC721: burn of token that is not own");

        _clearApproval(tokenId);

        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);


        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}
