"use client";

import {
  ProductDesignSubmission,
  ProductDesignSubmissionABI,
} from "../exports";
import React, { useState } from "react";
import web3 from "../web3";
import { uploadFileToIPFS } from "../ipfs";

const page = () => {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [imageFile, setImageFile] = useState(null);
  const [designFile, setDesignFile] = useState(null);

  const isFormValid = () => {
    return (
      name.trim() !== "" &&
      description.trim() !== "" &&
      imageFile !== null &&
      designFile !== null
    );
  };

  const submitDesign = async () => {
    try {
      if (!isFormValid()) {
        alert("Please fill in all required fields and upload files.");
        return;
      }

      const accounts = await web3.eth.getAccounts();
      const contract = new web3.eth.Contract(
        ProductDesignSubmissionABI,
        ProductDesignSubmission
      );

      const imageUrl = await uploadFileToIPFS(imageFile);
      const fileLink = await uploadFileToIPFS(designFile);

      try {
        await contract.methods
          .submitDesign(name, description, imageUrl, fileLink)
          .send({ from: accounts[0] });

        setName("");
        setDescription("");
        setImageFile(null);
        setDesignFile(null);

        alert("Design submitted successfully!");
      } catch (error) {
        console.error("Error submitting design to contract:", error);
        alert(`Error submitting design: ${error.message}`);
      }
    } catch (error) {
      console.error("Error submitting design:", error);
      alert("Error submitting design. Please try again.");
    }
  };

  return (
    <div className="submit">
      <h1>Submit Your Design</h1>
      <form>
        <label>Name:</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
        <label>Description:</label>
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          required
        ></textarea>
        <label>Image:</label>
        <input
          type="file"
          accept="image/*"
          onChange={(e) => setImageFile(e.target.files[0])}
          required
        />
        <label>Design File:</label>
        <input
          type="file"
          onChange={(e) => setDesignFile(e.target.files[0])}
          required
        />
        <button type="button" onClick={submitDesign} disabled={!isFormValid()}>
          Submit Design
        </button>
      </form>
    </div>
  );
};

export default page;
