An Exograph implementation of the model in the [Modelling Authorization for a Social Network with Postgres RLS and Drizzle ORM](https://neon.tech/blog/modelling-authorization-for-a-social-network-with-postgres-rls-and-drizzle-orm) blog.


## Try it out

1. Install the [latest version of Exograph (version 0.11.0 or higher)](https://exograph.dev/docs/getting-started). 

2. Run `exo test` to run the tests.

## Notes

1. `Message`, `Chat`, `Comment`, `Post` mark the fields of the `User` type as `@readonly`, If the `@readonly`-ness is not desired (for example, an admin can send a message on behalf of a user!), we can remove it without any other changes.

2. In the Exograph version, anyone can see any user's field (except for the email address, as intended in the RLS version, using field-level access rules), but only admins can mutate a user. This doesn't strictly match the RLS version, but it follows the domain expectation. If desired, we can introduce `UserDetails` (related to `User` through a one-to-one relationship) and have access rules on `UserDetails` instead.