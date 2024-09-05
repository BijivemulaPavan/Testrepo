// src/components/PostComments.js

import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { fetchComments } from './postApi';

const PostComments = () => {
  const { id } = useParams();
  const [comments, setComments] = useState([]);

  useEffect(() => {
    const loadComments = async () => {
      try {
        const data = await fetchComments(id);
        setComments(data);
      } catch (error) {
        console.error('Error fetching comments', error);
      }
    };
    loadComments();
  }, [id]);

  return (
    <div>
      <h2>Comments</h2>
      <ul>
        {comments.map(comment => (
          <li key={comment.id}>
            <h4>Name: {comment.name} <br/> Email: {comment.email} <br/> Body: {comment.body}</h4>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default PostComments;
