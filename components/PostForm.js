// src/components/PostForm.js

import React, { useState } from 'react';
import { createPost } from './postApi';

const PostForm = ({ onPostCreated }) => {
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');
  const [userId, setUserId] = useState(1);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const newPost = { title, body, userId };
    try {
      const data = await createPost(newPost);
      onPostCreated(data);
      setTitle('');
      setBody('');
      setUserId(1);
    } catch (error) {
      console.error('Error creating post', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2>Create New Post</h2>
      <input
        type="text"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        placeholder="Title"
        required
      />
      <textarea
        value={body}
        onChange={(e) => setBody(e.target.value)}
        placeholder="Body"
        required
      />
      <input
        type="number"
        value={userId}
        onChange={(e) => setUserId(e.target.value)}
        placeholder="User ID"
        required
      />
      <button type="submit">Create Post</button>
    </form>
  );
};

export default PostForm;
