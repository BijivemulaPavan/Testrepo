import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Link, useParams } from 'react-router-dom';

const PostList = () => {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        const response = await fetch('https://jsonplaceholder.typicode.com/posts'); // Replace with your API URL
        const data = await response.json();
        setPosts(data);
      } catch (error) {
        console.error('Error fetching posts', error);
      }
    };
    fetchPosts();
  }, []);

  return (
    <div>
      <h1>Posts</h1>
      <ul>
        {posts.map(post => (
          <li key={post.id}>
            <Link to={`/posts/${post.id}`}>Title : {post.title}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

const PostDetail = () => {
  const { id } = useParams();
  const [post, setPost] = useState(null);

  useEffect(() => {
    const fetchPost = async () => {
      try {
        const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`); // Replace with your API URL
        const data = await response.json();
        setPost(data);
      } catch (error) {
        console.error('Error fetching post', error);
      }
    };
    fetchPost();
  }, [id]);

  if (!post) return <p>Loading...</p>;

  return (
    <div>
      <h4>ID: {post.id} <br/> Title : {post.title} <br/> Body : {post.body}</h4>
      <Link to={`/posts/${id}/comments`}>View Comments</Link>
    </div>
  );
};

const PostComments = () => {
  const { id } = useParams();
  const [comments, setComments] = useState([]);

  useEffect(() => {
    const fetchComments = async () => {
      try {
        const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}/comments`); // Replace with your API URL
        const data = await response.json();
        setComments(data);
      } catch (error) {
        console.error('Error fetching comments', error);
      }
    };
    fetchComments();
  }, [id]);

  return (
    <div>
      <h2>Comments</h2>
      <ul>
        {comments.map(comment => (
          <li key={comment.id}>
            
            <h4>Name: {comment.name} <br/> Email: {comment.email} <br/> Body : {comment.body}</h4>

          </li>
        ))}
      </ul>
    </div>
  );
};

const App = () => {
  return (
    <Router>
      <div>
        <nav>
          <Link to="/">Home</Link>
        </nav>
        <Routes>
          <Route path="/" element={<PostList />} />
          <Route path="/posts/:id" element={<PostDetail />} />
          <Route path="/posts/:id/comments" element={<PostComments />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;
