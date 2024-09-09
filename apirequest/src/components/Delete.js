// DELETE  API
     const DeleteData = async(id)=>{ 
        try{
        const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`,{
            method:"DELETE" ,
        });
            if(response.ok){
                return true;
            }else{
                console.error("Failed to delete",response.statusText);
                return false;
            }
        }catch(e){
            console.error("Error While Deleting Data",e);
            return false;
        }
    };


export default DeleteData;
