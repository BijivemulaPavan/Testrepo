import React, { useState, useEffect } from 'react';
import {Link} from 'react-router-dom';

function Posts(){
    const [posts, setPosts] = useState([]);
  
    useEffect(() => {
      const fetchPosts = async () => {
        try {
          const response = await fetch("https://jsonplaceholder.typicode.com/posts"); 
          const items = await response.json();
          setPosts(items);
        } catch (e) {
          console.error("Error Unable to fetch the posts", e);
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
  export default Posts;