import React, { useState, useEffect } from 'react';
import {Link, useParams } from 'react-router-dom';

function Details() {
    const { id } = useParams();
    const [post, setPost] = useState(null);
  
    useEffect(() => {
      const fetchPost = async () => {
        try {
          const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`); 
          const items = await response.json();
          setPost(items);
        } catch (e) {
          console.error("Error Unable to fetch the posts", e);
        }
      };
      fetchPost();
    }, [id]);
  
    if (post==null) return ;
  
    return (
      <div>
        <h4>ID: {post.id} <br/> Title : {post.title} <br/> Body : {post.body}</h4>
        <Link to={`/posts/${id}/comments`}>View Comments</Link>
      </div>
    );
  };

export default Details;