pragma solidity ^0.5.0;


contract ProofOfExistence2 {
  // state
  bytes32[] private proofs;

  // store a proof of existence in the contract state
  // *transactional function*
  function storeProof(bytes32 proof) public {
    proofs.push(proof);
  }

  // calculate and store the proof for a document
  // *transactional function*
  function notarize(string calldata document) external {
    bytes32 proof = proofFor(document);
    storeProof(proof);
  }

  // helper function to get the document's sha256
  // *read-only function (pure)*
  function proofFor(string memory document) public pure returns(bytes32) {
    return sha256(abi.encodePacked(document));
  }

  // check if the document has been notarized
  // *read-only function*
  function checkDocument(string memory document) public view returns (bool) {
    bytes32 proof = proofFor(document);
    return hasProof(proof);
  }

  // returns true if proof is stored
  // *read-only function*
  function hasProof(bytes32 proof) internal view returns (bool) {
    for(uint256 counter = 0; counter < proofs.length; ++counter) {
      if(proof == proofs[counter]) {
        return true;
      }
    }
    return false;
  }
}
