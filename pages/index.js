import { useState } from 'react';
import { signIn, signOut, useSession, getSession } from 'next-auth/react';
import TweetEmbed from 'react-tweet-embed'
import axios from 'axios';
import {Button, AppBar, Toolbar, Typography, Box, TextField, Select, MenuItem, InputLabel, FormControl } from "@mui/material";


export default function Home() {
  const { data: session } = useSession()
  const [statuses,setStatuses]=useState([])
  console.log(session)
  const content = {
    key1: "value1",
    key2: "value2"
  };

  async function handleOnLastFiveTwitter(e){
    e.preventDefault()
    const resultados = await fetch('/api/twitter/lastfive'
    ).then(res => res.json());
    setStatuses(resultados.data);
  }

  async function handleOnLastFivePinterest(e){
    e.preventDefault()
    const resultados= await fetch('/api/pinterest/lastfive'
    ).then(res=>res.json())
    console.log(resultados.data)
  }

  async function handleOnTweetSubmit(e){
    e.preventDefault()
    
    const formData= new FormData(e.currentTarget)
    const status =formData.get('status')
    const resultados= await fetch('/api/twitter/tweet',{
      method:'POST',
      body:JSON.stringify({
        status
      })
    }).then(res=>res.json())
    alert('Success!!')
  }


  const handlereset=(e)=>{
    setStatuses([])
  }

  const [imageSrc, setImageSrc] = useState();
  const [uploadData, setUploadData] = useState();
  const [image, setImage] = useState(null);
  const [createObjectURL, setCreateObjectURL] = useState(null);

/*
  function handleOnChange(changeEvent) {
    const reader = new FileReader();
    
    reader.onload = function(onLoadEvent) {
      console.log(onLoadEvent.target)
      setImageSrc(onLoadEvent.target.result);
    }
    reader.readAsArrayBuffer(changeEvent.target.files[0]);
  
    if (changeEvent.target.files && changeEvent.target.files[0]) {
      const i = changeEvent.target.files[0];

      setImage(i);
      setCreateObjectURL(URL.createObjectURL(i));

    }

  
 }
*/
 const handleOnChange =(e)=>{
    let formData= new FormData();
    
    formData.append("data",JSON.stringify(content))
    formData.append("profile_picture",e.target.files[0])
  }

 /*
 console.log(image)
  console.log(createObjectURL)
  console.log(imageSrc)
  const dataImagen= new Uint8Array(imageSrc)
  console.log(dataImagen)
  */
  const handleTweetconfoto=async (e)=>{
    e.preventDefault()
    let formData= new FormData()
    formData.append("data", JSON.stringify(content))
    formData.append("picture",e.target[1].files[0])
    formData.append("texto",e.target[0].value)
    axios.put("/api/twitter/tweetimage",formData).then(console.log).catch(console.log);
    /*
    const status =formData.get('textstatus')
    const tweet={
      status,
      tamano,
      tipo,
      imageSrc,
      createObjectURL,
      dataImagen
    }
    console.log(tweet)    
    const resultados= await fetch('/api/twitter/tweetimage',{
      method:'POST',
      body:JSON.stringify({
        tweet
      })
    }).then(res=>res.json())
    alert('Success!!')
  */
  }

  if (session) {
    if (session.user.tipo==='pinterest'){
      return(
        <>
        Signed in as {session.user.email} <br />
        <Button variant="contained" onClick={() => signOut()}>Sign out</Button>
        <form onSubmit={handleOnLastFivePinterest}>
            <Typography variant="h5">lastfive</Typography>
            <Button type="onSubmit" variant="contained">Search</Button>
        </form>

        </>
      )
    }
    return (
      <>
        Signed in as {session.user.email} <br />
        <Button variant="contained" onClick={() => signOut()}>Sign out</Button>
        <form onSubmit={handleOnTweetSubmit}>
            <Typography variant="h5">Tweet</Typography>
            <TextField name="status" />
            <Button>Tweet</Button>
          </form>
        <form onSubmit={handleOnLastFiveTwitter}>
            <Typography variant="h5">lastfive</Typography>
            <Button type="onSubmit" variant="contained">Search</Button>
          </form>
        <Button variant="contained" onClick={handlereset}>Reset</Button>

        <form onSubmit={handleTweetconfoto}>
        <TextField name="textstatus" />
        <input type="file"  name="inputstatus"/>
        <Button  variant="contained"> Tweet con foto</Button>
        </form>
        

        {statuses.map(({id_str})=>{
          return(
            <div key={id_str}>
              <TweetEmbed id={id_str} options={{theme: 'dark' }}/>
            </div>
          )
        })}
      </>
    )
  }
  return (
    <>
      Not signed in <br />
      <Button  variant="contained" onClick={() => signIn()}>Sign in</Button>
    </>
    
  )
} 