export async function time(operation) {
	const start = performance.now();
	const result = await operation.proceed();
	const end = performance.now();
	console.log(`'${operation.name()}' took ${end - start} ms`);
	return result;
}
