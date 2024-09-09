//PUT API
import React, { useState } from 'react';
import { useParams } from 'react-router-dom';

function Update(){
    const {id}=useParams();
    const [PopUp, setPopUp] = useState(false);
    const [title, setTitle] = useState('');
    const [body, setBody] = useState('');
    const [response, setResponse] = useState(null);

    const handleSubmit=async()=>{
    const UpdateData={
      title,
      body,
    };
    try{
    const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`,{
        method:"PUT",
        headers:{
            "Content-Type": "application/json",
        },
        body: JSON.stringify(UpdateData),
    } );
    const data = await response.json();
    console.log("Items Updated Successfully",data);
    setResponse("Items Updated");
    }catch(e){
        console.error("Unable to Update Items",e);
    }
    setPopUp(false);
};

   const handleCancel=()=>{
    setPopUp(false);
 };

 return(
    <div>
         <button onClick={()=>setPopUp(true)}>Update</button> <br/>
            {PopUp &&
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
            
            <button onClick={handleSubmit}>Submit</button>
            <button onClick={handleCancel}>Cancel</button>
            </div>
            }
        {response && <div>{response}</div>}
    </div>
 );
 };
 export default Update;