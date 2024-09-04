import React, { useState, useEffect } from 'react';
import {useParams } from 'react-router-dom';

function Comments() {
    const { id } = useParams();
    const [comments, setComments] = useState([]);
  
    useEffect(() => {
      const fetchComments = async () => {
        try {
          const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}/comments`); 
          const items = await response.json();
          setComments(items);
        } catch (e) {
          console.error("Error Unable to fetch the posts", e);
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

export default Comments;