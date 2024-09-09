//PATCH API
import React, { useState } from 'react';
import { useParams } from 'react-router-dom';

function Patch(){
    const {id}=useParams();
    const [popup, setpopup] = useState(false);
    const [title, setTitle] = useState('');
    const [body, setBody] = useState('');
    const [response, setResponse] = useState(null);


    const handlePatchSubmit=async()=>{
    const patchData={
      title:title,
      body: body,
    };
    try{
    const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`,{
        method:"PATCH",
        headers:{
            "Content-Type": "application/json",
        },
        body: JSON.stringify({patchData}),
    } );
    const data = await response.json();
    console.log("Items Partially Updated Successfully",data);
    setResponse("Items Partially Updated");
    }catch(e){
        console.error("Unable to Partially update Items",e);
    }
    setpopup(false);
};

   const handleCancel=()=>{
    setpopup(false);
 };

 return(
    <div>
        <button onClick={()=>setpopup(true)}>Patch</button><br/>
        {popup &&
                <div>
            <h3>Enter Details</h3>
        <div>
        <label>Title :</label>
            <input type='text' value={title} onChange={(e)=>setTitle(e.target.value)} 
            placeholder='Title' required /></div>
            <div>
            <label>Body :</label>
            <input type='text' value={body} onChange={(e)=>setBody(e.target.value)} 
            placeholder='Body' required />
            </div>
            <button onClick={handlePatchSubmit}>Patch Submit</button>
            <button onClick={handleCancel}>Cancel</button>
            </div>
            }
            {response && <div>{response}</div>}
    </div>
 )
    
 };
 export default Patch;




