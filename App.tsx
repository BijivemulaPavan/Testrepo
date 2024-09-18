import React from 'react';
import './App.css';
import Navbar from './components/NavBar';
import Content from './components/Content';
import Footer from './components/Footer';

function App() {
  return (
    <div>
      {/* Navigation Bar */}
      <div className="navbar">
        <div>Business Functionality</div>
      </div>

      {/* Container with Panels */}
      <div className="container">
        <div className="left-panel">
          <div>
            <span className="line-number">0001</span>
            <span className="keyword">IDENTIFICATION DIVISION.</span>
          </div>
          <div>
            <span className="line-number">0002</span>
            <span className="keyword">PROGRAM-ID.</span> CDP651.
          </div>
          <div>
            <span className="line-number">0003</span>
            <span className="keyword">ENVIRONMENT DIVISION.</span>
          </div>
          <div>
            <span className="line-number">0004</span>
            <span className="keyword">CONFIGURATION SECTION.</span>
          </div>
          <div>
            <span className="line-number">0005</span>
            <span className="keyword">SOURCE-COMPUTER.</span> IBM-370.
          </div>
          <div>
            <span className="line-number">0006</span>
            <span className="keyword">OBJECT-COMPUTER.</span> IBM-370.
          </div>
          <div>
            <span className="line-number">0007</span>/
          </div>
          <div>
            <span className="line-number">0008</span>
            <span className="keyword">DATA DIVISION.</span>
          </div>
          <div>
            <span className="line-number">0009</span>
            <span className="keyword">WORKING-STORAGE SECTION.</span>
          </div>
          <div>
            <span className="line-number">0010</span>01 N-A-M-E-D PIC X(32) VALUE <span className="string">"-CDP65102 WORKING STORAGE START-</span>".
          </div>
          <div>
            <span className="line-number">0011</span>01 PROGRAM-CONSTANTS.
          </div>
          <div>
            <span className="line-number">0012</span>05 CZPDAT PIC X(8) VALUE <span className="string">"CZPDAT"</span>.
          </div>
        </div>

        <div className="right-panel">
          <div>
            <span className="keyword">Main.cbl</span>
          </div>
          <div className="highlight">
            <span className="keyword">IDENTIFICATION DIVISION</span>
          </div>
          <div>PERFORM Z100-INITIALIZE THRO Z100-EXIT</div>
          <div className="highlight">Z100-INITIALIZE</div>
          <div>Z100-EXIT</div>
          <div>PERFORM A100-CURR-CONVERTION-PROCESS</div>
          <div className="highlight">A100-CURR-CONVERTION-PROCESS</div>
          <div>PERFORM A110-GET-CONV-FROM</div>
          <div className="highlight">A110-GET-CONV-FROM</div>
          <div>PERFORM Z4000-CALL-RDX000</div>
          <div className="highlight">Z4000-CALL-RDX000</div>
          <div>GO TO Z4000-EXIT</div>
          <div className="highlight">Z4000-EXIT</div>
          <div>PERFORM Z9400-CALL-CSPDAT</div>
          <div className="highlight">Z9400-CALL-CSPDAT</div>
        </div>
      </div>

      {/* Bottom Bar */}
      <div className="bottom-bar">
        <div>
          <button>&#x2190;</button>
          <button>&#x2192;</button>
          <button>&#x21bb;</button>
        </div>
        <div>
          <select>
            <option>Normal text</option>
          </select>
          <input type="text" placeholder="Describe your logic here" />
        </div>
        <div>
          <button>&#x1f4c4;</button>
          <button>&#x1f4dd;</button>
          <button>&#x1f4c3;</button>
          <button>&#x1f4cb;</button>
        </div>
      </div>
    </div>
  );
};
  

export default App;