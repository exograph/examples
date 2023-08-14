import { ExographPriv } from "../../generated/exograph.d.ts";

const adminContext = {
  AuthContext: {
    role: "admin",
  },
};

export interface JWTPayload extends Record<string, unknown> {
  sub: string;
  email: string;
  firstName: string;
  lastName: string;
  profileImageUrl: string;
}


export async function queryUserInfo(email: string, exo: ExographPriv): Promise<JWTPayload> {
  const res = await exo.executeQueryPriv(
    `query($email: String!) {
        users(where: { email: { eq: $email }}) {
            id
            firstName
            lastName
            profileImageUrl
        }
    }`,
    { email },
    adminContext
  );

  if (res.users.length !== 1) {
    throw new ExographError("Failed to login"); // Intentionally vague to avoid disclosing user existence
  }

  const user = res.users[0];

  return {
    sub: user.id,
    firstName: user.firstName,
    lastName: user.lastName,
    email: email,
    profileImageUrl: user.profileImageUrl,
  };
}


export async function createUser(email: string, firstName: string, lastName: string, profileImageUrl: string, exo: ExographPriv): Promise<number> {
  try {
    const res = await exo.executeQueryPriv(
      `mutation($email: String!, $firstName: String!, $lastName: String!, $lastName: String!, $profileImageUrl: String!) {
        createUser(data: { email: $email, firstName: $firstName, lastName: $lastName, profileImageUrl: $profileImageUrl}) {
          id
        }
    }`,
      { email, firstName, lastName, profileImageUrl },
      adminContext
    );
    return res.createUser.id as number;
  } catch (e) {
    throw new ExographError("Failed to create user");
  }
}
