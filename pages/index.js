import { useState } from 'react';
import Head from 'next/head'
import Image from 'next/image'
import { signIn, signOut, useSession, getSession } from 'next-auth/react';

import styles from '../styles/Home.module.css'

export default function Home() {
  const { data: session } = useSession()
  if (session) {
    return (
      <>
        Signed in as {session.user.email} <br />
        <button onClick={() => signOut()}>Sign out</button>
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