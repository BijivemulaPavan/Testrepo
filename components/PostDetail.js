// src/components/PostDetail.js

import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { fetchPostById, updatePost, partialUpdatePost, deletePost } from './postApi';

const PostDetail = () => {
  const { id } = useParams();
  const [post, setPost] = useState(null);

  useEffect(() => {
    const loadPost = async () => {
      try {
        const data = await fetchPostById(id);
        setPost(data);
      } catch (error) {
        console.error('Error fetching post', error);
      }
    };
    loadPost();
  }, [id]);

  const handleUpdate = async () => {
    const updatedPost = {
      title: 'Updated Title',
      body: 'Updated Body',
      userId: 1,
    };
    try {
      const data = await updatePost(id, updatedPost);
      setPost(data);
      alert('Post updated successfully');
    } catch (error) {
      console.error('Error updating post', error);
    }
  };

  const handlePartialUpdate = async () => {
    const partialPost = {
      title: 'Partially Updated Title',
    };
    try {
      const data = await partialUpdatePost(id, partialPost);
      setPost(data);
      alert('Post partially updated successfully');
    } catch (error) {
      console.error('Error partially updating post', error);
    }
  };

  const handleDelete = async () => {
    try {
      const success = await deletePost(id);
      if (success) {
        alert('Post deleted successfully');
        setPost(null); // Optionally clear the post
      } else {
        alert('Failed to delete post');
      }
    } catch (error) {
      console.error('Error deleting post', error);
    }
  };

  if (!post) return <p>Loading...</p>;

  return (
    <div>
      <h4>ID: {post.id} <br/> Title: {post.title} <br/> Body: {post.body}</h4>
      <button onClick={handleUpdate}>Update Post</button>
      <button onClick={handlePartialUpdate}>Partially Update Post</button>
      <button onClick={handleDelete}>Delete Post</button>
      <Link to={`/posts/${id}/comments`}>View Comments</Link>
    </div>
  );
};

export default PostDetail;
