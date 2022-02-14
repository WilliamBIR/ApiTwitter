const Twitter     = require('twitter');
import {getSession} from 'next-auth/react'
import {getToken} from 'next-auth/jwt'
import { readBuilderProgram } from 'typescript';
import {IncomingForm} from "formidable"

export const config={
    api:{
        bodyParser:false
    }
}

const asyncParse=(req)=>
    new Promise((resolve,reject)=>{
        const form = new IncomingForm({multiples: true})
        form.parse(req,(err,fields,files)=>{
            if(err) return reject(err);
            resolve({fields, files})
        })
    })

export default async function handler(req,res){
    console.log("Receiving")
    if(req.method==="PUT"){
        const result= await asyncParse(req)
        //console.log(result)
        //console.log(result.fields.texto)
        //console.log(result.files.picture.filepath)

        const mediaData = require("fs").readFileSync(result.files.picture.filepath)
        const session= await getSession({req})
        const token= await getToken({
            req,
            secret: process.env.NEXTAUTH_SECRET
        })
        const client = new Twitter({
            consumer_key:process.env.TWITTER_CONSUMER_KEY,
            consumer_secret:process.env.TWITTER_CONSUMER_SECRET,
            access_token_key:token.twitter.oauth_token,
            access_token_secret:token.twitter.oauth_token_secret,
        });
        try{
            console.log('intentando')
            var prueba= await client.post('media/upload',{media:mediaData}, function(error,media,response){
            if(!error){
                console.log(media)
                var status={
                    status:result.fields.texto,
                    media_ids:media.media_id_string
                }
                client.post('statuses/update', status, function(error, tweet, response) {
                    if (!error) {
                      console.log(tweet);
                    }
                  });
            }
            else{
                console.log('error')
            }
        })
      
        return res.status(200).json({
            status:'Ok',
        })
        }catch(e){
            console.log('error')
            return res.status(400).json({
                status:e.message
            })
        }
        

    }
}

