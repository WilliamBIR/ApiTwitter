import NextAuth from 'next-auth';
import TwitterProvider from "next-auth/providers/twitter";

export default NextAuth({
  providers: [
    TwitterProvider({
      clientId: process.env.TWITTER_CONSUMER_KEY,
      clientSecret: process.env.TWITTER_CONSUMER_SECRET
    }),
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