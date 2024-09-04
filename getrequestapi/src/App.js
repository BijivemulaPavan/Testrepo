import React from 'react';
import { BrowserRouter, Route, Routes, Link } from 'react-router-dom';
import Posts from './components/Posts';
import Details from './components/Details';
import Comments from './components/Comments';

function App() {
  return (
    <BrowserRouter>
      <div>
        <nav>
          <Link to="/">Home</Link>
        </nav>
        <Routes>
          <Route path="/" element={<Posts />} />
          <Route path="/posts/:id" element={<Details />} />
          <Route path="/posts/:id/comments" element={<Comments />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
};

export default App;