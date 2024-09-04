import React,{useState} from "react";

const AddItems=()=>{
    const [title, setTitle] = useState('');
    const [body, setBody] = useState('');
    const [status, setStatus] = useState('');
 

    const handleSubmit = async(e)=>{
        e.preventDefault();

        try{
            const response = await fetch("https://jsonplaceholder.typicode.com/posts",{
                method : "post",
                headers : {
                    'Content-Type' : 'application/json'
                },
                body : JSON.stringify({title, body,userId:1}), 
            });
            
            if(!response.ok){
                throw new Error(`Failed to add items to post: ${response.status}`);
            }
            const data=await response.json();
            console.log("Items Added: ",data)
            setTitle("");
            setBody("");
            }catch(e){
                setStatus("Error while Adding Items")
                console.error("Error while Adding Items",e);
            }
        };
        return(
            <div>
                <h2>Add New Data </h2>
                <form onSubmit={handleSubmit}>
                    <div>
                        <label>Title :
                        <input type="text" value = {title} onChange={(e) => setTitle(e.target.value)} 
                        required /></label>
                        <label>Body :
                        <input type="text" value = {body} onChange={(e) => setBody(e.target.value)} 
                        required /></label>
                    </div>
                    <button type="submit">Add Post</button>
                </form>
                {status && <p>{status}</p>}

            </div>
        );

    };

export default AddItems;


































