import { create } from "ipfs-http-client";

const ipfs = create({ url: "https://ipfs.infura.io:5001/api/v0" });

export const uploadFileToIPFS = async (file) => {
  try {
    const added = await ipfs.add(file, { pin: true });
    const ipfsLink = `https://ipfs.io/ipfs/${added.path}`;
    return ipfsLink;
  } catch (error) {
    console.error("Error uploading file to IPFS:", error);
    throw error;
  }
};
