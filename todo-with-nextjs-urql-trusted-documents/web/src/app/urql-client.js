import { Client, cacheExchange, fetchExchange } from 'urql';
import { persistedExchange } from '@urql/exchange-persisted'


export const client = new Client({
  url: process.env.NEXT_PUBLIC_GRAPHQL_URL,
  exchanges: [
    cacheExchange,
    persistedExchange({
      enforcePersistedQueries: true,
      enableForMutation: true,
      generateHash: (_, document) => Promise.resolve(document['__meta__']['hash'])
    }),
    fetchExchange,
  ],
});