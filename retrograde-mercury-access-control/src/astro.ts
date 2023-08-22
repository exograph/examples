export async function mercuryRetrograde(): Promise<boolean> {
	let result = await fetch("https://mercuryretrogradeapi.com");
	let json = await result.json();
	return json.is_retrograde;
}

