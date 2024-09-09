//POST API
import React, { useState } from 'react'

function PostData() {
    const [title, setTitle] = useState('');
    const [userid, setuserId] = useState('');
    const [body, setBody] = useState('');
    const [response, setResponse] = useState(null);
    const [popup, setPopUp]= useState(false);

    const handleSubmit = async()=>{
        const createData={
          title,
          body,
          userid,
        };
    
    try{
    const response = await fetch(`https://jsonplaceholder.typicode.com/posts`,{
        method:"POST",
        headers:{
            "Content-Type": "application/json",
        },
        body: JSON.stringify(createData),
    } );
    const data = await response.json();
    console.log(" Data Added to Post Successfully",data);
    setResponse("Items Added Successfully");
    
    }catch(e){
        console.error("Unable to add Items to posts",e);
    }
      setPopUp(false);
   };

   const handleCancel=()=>{
    setPopUp(false);
 };
return(
    <div>
 <button onClick={()=>setPopUp(true)}>Create Data</button>
            {popup &&
                <div>
            <h3>Enter Details</h3>
            <div>
            <label>ID :</label>
            <input type='number' value={userid} onChange={(e)=>setuserId(e.target.value)} 
            placeholder='ID' required /></div>
        <div>
            <label>Title :</label>
            <input type='text' value={title} onChange={(e)=>setTitle(e.target.value)} 
            placeholder='Title' required /></div>
            <div>
            <label>Body :</label>
            <input type='text' value={body} onChange={(e)=>setBody(e.target.value)} 
            placeholder='Body' required />
            </div>
            
            <button onClick={handleSubmit}>Submit</button>
            <button onClick={handleCancel}>Cancel</button>
            </div>
            }
            {response && <div>{response}</div>}
            </div>
        )

 };

export default PostData;
























