pragma solidity ^0.5.0;


contract ProofOfExistence3 {
  mapping (bytes32 => bool) private proofs;

  // store a proof of existence in the contract state
  function storeProof(bytes32 proof) internal {
    proofs[proof] = true;
  }

  // calculate and store proof or a document
  function notarize(string calldata document) external {
    bytes32 proof = proofFor(document);
    storeProof(proof);
  }

  // helper function to store document's sha256
  function proofFor(string memory document) public pure returns (bytes32) {
    return keccak256(bytes(document));
  }

  // check if the document has been notarized
  function checkDocument(string memory document) public view returns (bool) {
    bytes32 proof = proofFor(document);
    return hasProof(proof);
  }

  // returns true if proof is already stored
  function hasProof(bytes32 proof) public view returns (bool) {
    return proofs[proof];
  }
}
