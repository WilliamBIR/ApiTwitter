import NextAuth from 'next-auth';
import TwitterProvider from "next-auth/providers/twitter";

export default NextAuth({
  providers: [
    TwitterProvider({
      clientId: process.env.TWITTER_CONSUMER_KEY,
      clientSecret: process.env.TWITTER_CONSUMER_SECRET
    }),
    {
      id:"pinterest",
      name:"Pinterest",
      type:"oauth",
      authorization:{
          url:"https://www.pinterest.com/oauth",
          params:{
              scope:"user_accounts:read,boards:read,pins:read,ads:read,boards:write,pins:write"
          }
      },
      accessTokenUrl:"https://api.pinterest.com/v5/oauth/token",
      clientId:process.env.AUTH0_PINTEREST_ID,
      clientSecret:process.env.AUTH0_PINTEREST_SECRET,
      userinfo:"https://api.pinterest.com/v5/user_account"
  }
  ],
  callbacks: {
    jwt: async ({ token, user, account={}, profile, isNewUser }) => {
  
      if(account.provider && !token[account.provider]){
        token[account.provider]={}
      }
      if(account.oauth_token){
        token[account.provider].oauth_token=account.oauth_token
      }
      if(account.oauth_token_secret){
        token[account.provider].oauth_token_secret=account.oauth_token_secret
      }
      user && (token.user = user)
      return token
  },
  session: async ({ session, token }) => {
      session.user = token.user
      return session
  }
  },
  secret: process.env.NEXTAUTH_SECRET
});