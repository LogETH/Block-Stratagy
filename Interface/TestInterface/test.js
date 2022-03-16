'use strict'
'npm install web3'

const ethereumButton = document.querySelector('.enableEthereumButton');

ethereumButton.addEventListener('click', () => {
  //Will Start the metamask extension
  ethereum.request({ method: 'eth_requestAccounts' });
});

function myFunction(){
  
  alert ("hello log");
}

