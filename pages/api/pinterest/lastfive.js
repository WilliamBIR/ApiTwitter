import {getSession} from 'next-auth/react'
import {getToken} from 'next-auth/jwt'

const lastfive= async (req,res)=>{
    const session= await getSession({req})
    const token= await getToken({
        req,
        secret: process.env.NEXTAUTH_SECRET
    })
    /*
    console.log('session')
    console.log(session.user.id)
    console.log('token')
    console.log(token)    
    console.log('ouath token')
    console.log(token.pinterest.oauth_token)
    */
    try{
        const punks=await fetch(`https://api.pinterest.com/v3/pidgets/users/${session.user.id}/pins/?page_size=1`)
        const resultados= await punks.json()
        console.log(resultados)
        return res.status(200).json({
            status:'Ok',
            data:resultados.data?.pins
        })
    }catch(e){
    return res.status(400).json({
        status:e.message
    })
}
}

export default lastfive