// src/api/postApi.js

const API_BASE_URL = 'https://jsonplaceholder.typicode.com';

// Fetch all posts
export const fetchPosts = async () => {
  const response = await fetch(`${API_BASE_URL}/posts`);
  return response.json();
};

// Fetch a post by ID
export const fetchPostById = async (id) => {
  const response = await fetch(`${API_BASE_URL}/posts/${id}`);
  return response.json();
};

// Fetch comments for a specific post
export const fetchComments = async (postId) => {
  const response = await fetch(`${API_BASE_URL}/posts/${postId}/comments`);
  return response.json();
};

// Create a new post (POST)
export const createPost = async (post) => {
  const response = await fetch(`${API_BASE_URL}/posts`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(post),
  });
  return response.json();
};

// Update a post by ID (PUT)
export const updatePost = async (id, post) => {
  const response = await fetch(`${API_BASE_URL}/posts/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(post),
  });
  return response.json();
};

// Partially update a post by ID (PATCH)
export const partialUpdatePost = async (id, post) => {
  const response = await fetch(`${API_BASE_URL}/posts/${id}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(post),
  });
  return response.json();
};

// Delete a post by ID
export const deletePost = async (id) => {
  const response = await fetch(`${API_BASE_URL}/posts/${id}`, {
    method: 'DELETE',
  });
  return response.ok;
};
