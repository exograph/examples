import type { ExographPriv } from '../../generated/exograph.d.ts';
import { LoginResult, verifyGoogle } from './login-google.ts';
import { createJwt } from "./jwt.ts";
import { createUser, queryUserInfo } from './user-admin.ts';

export const secret = Deno.env.get("EXO_JWT_SECRET");

if (!secret) throw new Error("Env EXO_JWT_SECRET must be defined.");

export async function login(code: string, exo: ExographPriv): Promise<string> {
	const googleUser: LoginResult = await verifyGoogle(code);
	const payload = await queryUserInfo(googleUser.email, exo);
	return await createJwt(payload, secret as string);
}

export async function signup(code: string, exo: ExographPriv): Promise<string> {
	const googleUser: LoginResult = await verifyGoogle(code);
	await createUser(googleUser.email, googleUser.firstName, googleUser.lastName, googleUser.profileImageUrl, exo);
	const payload = await queryUserInfo(googleUser.email, exo);
	return await createJwt(payload, secret as string);
}
