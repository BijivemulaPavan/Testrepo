import React from 'react';
import { BrowserRouter, Route, Routes} from 'react-router-dom';
import Posts from './components/Posts';
import Details from './components/Details';
import Comments from './components/Comments';
import PostData from './components/PostData';


function App() {
  return (
    <BrowserRouter>
      <div>
        <button>
          <a href='/'>Home</a>
        </button>
        <PostData/>
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