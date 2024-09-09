//GET API
import React, { useState, useEffect } from 'react';
import {Link, useParams } from 'react-router-dom';
import  DeleteData from './Delete';
import Update from './Update'
import Patch from './Patch';

function Details() {
  const {id}=useParams();
    const [post, setPost] = useState('');

    useEffect(() => {
      const fetchPost = async () => {
        try {
          const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`); 
          const data = await response.json();
          setPost(data);
        } catch (e) {
          console.error("Error Unable to fetch the posts", e);
        }
      };
      fetchPost();
    }, [id]);

    const handleDelete = async()=>{
      try{
        const success = await DeleteData(id);
        if(success){
          console.log("Post Deleted Successfully");
          alert("Post Deleted Successfully");
          setPost(null);
        }else{
          alert("Failed to Delete");
        }
      }catch(e){
        console.error("Failed to Delete",e);
      }
    }
  
    if (!post) return;
  
    return (
      <div>
        <h1>Post Details</h1>
        <h4>ID: {post.id} <br/> Title : {post.title} <br/> Body : {post.body}</h4>
        <button><Link to={`/posts/${id}/comments`}>View Comments</Link></button> 
        <Patch/>
        <Update/> 
        <button onClick={handleDelete}>Delete Post</button> <br/>
      </div>
    );
  };

export default Details;