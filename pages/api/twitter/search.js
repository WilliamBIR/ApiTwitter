import {getSession} from 'next-auth/react'
import {getToken} from 'next-auth/jwt'
import Twitter from 'twitter-lite'

export default async (req,res)=>{
    const body=JSON.parse(req.body)
    const {query}=body;
    console.log(query)

    const session=await getSession({req});
    const token= await getToken({
        req,
        secret: process.env.NEXTAUTH_SECRET
    });
    console.log('session', session)
    console.log('token', token)

    const client= new Twitter({
        consumer_key:process.env.TWITTER_CONSUMER_KEY,
        consumer_secret:process.env.TWITTER_CONSUMER_SECRET,
        access_token_key:token.twitter.accessToken,
        access_token_secret:token.twitter.refreshToken
    })



   try{
    const results = await client.get('search/tweets',{
        q:query
    })
    return res.status(200).json({
        status:'Ok',
        data:results
    });
   } catch(e){
        return res.status(400).json({
            status: e.message
        });
   }
}