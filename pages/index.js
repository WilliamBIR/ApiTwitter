import { useState } from 'react';
import Head from 'next/head'
import Image from 'next/image'
import { signIn, signOut, useSession, getSession } from 'next-auth/react';
import TweetEmbed from 'react-tweet-embed'

import styles from '../styles/Home.module.css'

export default function Home() {
  const { data: session } = useSession()
  const [statuses,setStatuses]=useState([])

  async function handleOnLastFive(e){
    e.preventDefault()

    const resultados = await fetch('/api/twitter/lastfive'
    ).then(res => res.json());
    
    setStatuses(resultados.data);
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
  console.log(statuses)

  if (session) {
    return (
      <>
        Signed in as {session.user.email} <br />
        <button onClick={() => signOut()}>Sign out</button>
        <form onSubmit={handleOnTweetSubmit}>
            <h2>Tweet</h2>
            <textarea name="status" />
            <button>Tweet</button>
          </form>
        <form onSubmit={handleOnLastFive}>
            <h2>lastfive</h2>
            <button>Search</button>
          </form>
        <button onClick={handlereset}>Reset</button>

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
      <button onClick={() => signIn()}>Sign in</button>
    </>
  )
} 