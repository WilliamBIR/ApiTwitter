import NextAuth from 'next-auth';
import TwitterProvider from "next-auth/providers/twitter";
export default NextAuth({
  providers: [
    TwitterProvider({
      clientId: process.env.TWITTER_CONSUMER_KEY,
      clientSecret: process.env.TWITTER_CONSUMER_SECRET
    }),
    {
    id: "pinterest",
     name: "Pinterest",
            type: "oauth",
            version: "2.0",
            token: "https://api.pinterest.com/v5/oauth/token",
                authorization: {
      url: "https://www.pinterest.com/oauth",
      params: {
        audience: "api.pinterest.com",
        prompt: "consent",
        scope: "ads:read,boards:read,boards:write,pins:read,pins:write,user_accounts:read",
      },
    },
      token: "https://api.pinterest.com/v5/oauth/token",
      userinfo: {
      url: "https://api.pinterest.com/v5/user_account",
      async request({ client, tokens }) {
        // Get base profile
        const profile = await client.userinfo(tokens)
        // no email info from Pinterest API
            if (!profile.email) {
              profile.email = profile.username 
        }
        return profile
      },
    },
      clientId: process.env.PINTEREST_CLIENT_ID,
      clientSecret: process.env.PINTEREST_CLIENT_SECRET,
           
    profile(profile, accessToken) {
    return {
      id: profile.username,
      name: profile.username,
      email: profile.email,
      image: profile.profile_image,
      tipo:'pinterest',
    }
    },
      checks: "state",
      headers: {},
      authorizationParams: {
                client_id: process.env.PINTEREST_CLIENT_ID,
                redirect_uri: encodeURIComponent(process.env.PINTEREST_REDIRECT_URI),
            },
    },
  ],
  callbacks: {
    jwt: async ({ token, user, account={}, profile, isNewUser }) => {
      //console.log('account')
      //console.log(account)
      if(account.provider && account.provider==='pinterest'){
        if(!token[account.provider]){
          token[account.provider]={}
        }
        if(account.access_token){
          token[account.provider].oauth_token=account.access_token
        }
      }
      if(account.provider &&account.provider==='twitter'){
      if(account.provider && !token[account.provider]){
        token[account.provider]={}
      }
      if(account.oauth_token){
        token[account.provider].oauth_token=account.oauth_token
      }
      if(account.oauth_token_secret){
        token[account.provider].oauth_token_secret=account.oauth_token_secret
      }
      }
      user && (token.user = user)
      //console.log('token')
      //console.log(token)

      return token
  },
  session: async ({ session, token }) => {
      session.user = token.user
      return session
  }
  },
  secret: process.env.NEXTAUTH_SECRET
});

