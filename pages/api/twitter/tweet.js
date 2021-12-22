import { TwitterClient } from 'twitter-api-client'
import {getSession} from 'next-auth/react'
import {getToken} from 'next-auth/jwt'

export default async (req,res)=>{
    const body=JSON.parse(req.body)
    const {status}= body
    console.log(status)
    const session= await getSession({req})
    const token= await getToken({
        req,
        secret: process.env.NEXTAUTH_SECRET
    })

    const twitterClient = new TwitterClient({
        apiKey:process.env.TWITTER_CONSUMER_KEY,
        apiSecret:process.env.TWITTER_CONSUMER_SECRET,
        accessToken:token.twitter.oauth_token,
        accessTokenSecret:token.twitter.oauth_token_secret,
    });
    
    try{
        const resultados= await twitterClient.tweetsV2.createTweet({
            text:status
        })
        //console.log(resultados)
        return res.status(200).json({
            status:'Ok',
            data:resultados
        })
        
    }catch(e){
        return res.status(400).json({
            status:e.message
        })
    }
}
