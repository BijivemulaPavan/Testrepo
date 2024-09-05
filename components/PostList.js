// src/components/PostList.js

import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { fetchPosts } from './postApi';

const PostList = () => {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    const loadPosts = async () => {
      try {
        const data = await fetchPosts();
        setPosts(data);
      } catch (error) {
        console.error('Error fetching posts', error);
      }
    };
    loadPosts();
  }, []);

  return (
    <div>
      <h1>Posts</h1>
      <ul>
        {posts.map(post => (
          <li key={post.id}>
            <Link to={`/posts/${post.id}`}>Title: {post.title}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default PostList;
