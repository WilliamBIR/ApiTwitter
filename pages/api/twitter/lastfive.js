import { TwitterClient } from 'twitter-api-client'
import {getSession} from 'next-auth/react'
import {getToken} from 'next-auth/jwt'

const lastfive= async (req,res)=>{
    //const body=JSON.parse(req.body)
    //const {query}= body
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
        const resultados= await twitterClient.tweets.statusesUserTimeline({
            user_id:parseInt(session.user.id),
            count:5
        })
        
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

export default lastfive