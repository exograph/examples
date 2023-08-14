import { create, getNumericDate, verify } from "https://deno.land/x/djwt@v2.9.1/mod.ts";

export async function createJwt(payload: Record<string, unknown>, secret: string): Promise<string> {
  return await create(
    { alg: "HS256", typ: "JWT" },
    { exp: computeExpiry(60 * 60 * 1), ...payload }, // 1 hour
    await computeKey(secret)
  );
}

async function computeKey(secret: string) {
  const encoder = new TextEncoder();
  const keyBuf = encoder.encode(secret);
  return await crypto.subtle.importKey("raw", keyBuf, { name: "HMAC", hash: "SHA-256" }, true, [
    "sign",
    "verify",
  ]);
}

function computeExpiry(expirationPeriodSeconds: number): number {
  return getNumericDate(expirationPeriodSeconds);
}
