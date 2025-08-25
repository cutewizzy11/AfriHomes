import app from './app';
import { env } from './config/env';
import { connectToDatabase } from './config/db';

async function bootstrap(): Promise<void> {
  try {
    if (env.mongoUri) {
      await connectToDatabase(env.mongoUri);
    }
    app.listen(env.port, () => {
      // eslint-disable-next-line no-console
      console.log(`API running on http://localhost:${env.port}`);
    });
  } catch (error) {
    // eslint-disable-next-line no-console
    console.error('Failed to start server', error);
    process.exit(1);
  }
}

bootstrap();

