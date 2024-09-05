// src/App.js

import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import PostList from './components/PostList';
import PostDetail from './components/PostDetail';
import PostComments from './components/PostComments';
import PostForm from './components/PostForm';

const App = () => {
  const [posts, setPosts] = useState([]);

  const handlePostCreated = (newPost) => {
    setPosts((prevPosts) => [newPost, ...prevPosts]);
  };

  return (
    <Router>
      <div>
        <nav>
          <Link to="/">Home</Link> | <Link to="/create-post">Create Post</Link>
        </nav>
        <Routes>
          <Route path="/" element={<PostList />} />
          <Route path="/posts/:id" element={<PostDetail />} />
          <Route path="/posts/:id/comments" element={<PostComments />} />
          <Route path="/create-post" element={<PostForm onPostCreated={handlePostCreated} />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;
