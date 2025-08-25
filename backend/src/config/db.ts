import mongoose from 'mongoose';

export async function connectToDatabase(uri: string): Promise<void> {
  if (!uri) {
    return; // Optional in dev: skip if not provided
  }
  if (mongoose.connection.readyState === 1) return;
  await mongoose.connect(uri, {
    // @ts-expect-error Mongoose v8 accepts connection string options implicitly
  });
}

export function getDbState(): 'disconnected' | 'connecting' | 'connected' | 'disconnecting' {
  const state = mongoose.connection.readyState;
  switch (state) {
    case 0:
      return 'disconnected';
    case 1:
      return 'connected';
    case 2:
      return 'connecting';
    case 3:
      return 'disconnecting';
    default:
      return 'disconnected';
  }
}

