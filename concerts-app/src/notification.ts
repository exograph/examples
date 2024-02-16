import type { Exograph } from "./exograph";

export async function sendNotification(concertId: number, exograph: Exograph): Promise<boolean> {
	const concertOperation = await exograph.executeQuery(`
		query($concertId: Int!) {
			concert(id: $concertId) {
				title
			}
		}`,
		{
			"concertId": concertId
		}
	);
	const subscribersOperation = await exograph.executeQuery(`
		{
			subscribers(where: {subscribed: {eq: true}}) {
				email
			}
		}`
	);

	const concertTitle = concertOperation.concert.title;
	const subscriberEmails = subscribersOperation.subscribers.map(subscriber => subscriber.email);

	const emailBody = `
    <h1>${concertTitle}</h1>
    <p>You have been invited to the concert!</p>
	`;

	return await sendEmail(subscriberEmails, "Concert Announcement", emailBody);
}


async function sendEmail(
	to: string[],
	subject: string,
	body: string
): Promise<boolean> {
	console.log(
		`Sending email
     to: ${to.join(', ')},
     subject: ${subject},
     body: ${body}`
	);
	return true;
}