import * as Joi from 'joi';

const configSchema = Joi.object({
  //APP
  PORT: Joi.string().required(),
  ENVIRONMENT: Joi.equal('development', 'production').required(),
  BACKEND_URL: Joi.string().required(),

  //POSTGRESQL
  DATABASE_URL: Joi.string().required(),
  DB_USER: Joi.string().required(),
  DB_NAME: Joi.string().required(),
  DB_PASSWORD: Joi.string().required(),

  //MONGODB
  MONGO_HOST: Joi.string().required(),
  MONGO_USERNAME: Joi.string().required(),
  MONGO_DATABASE: Joi.string().required(),
  MONGO_PASSWORD: Joi.string().required(),

  //MINIO
  MINIO_ENDPOINT: Joi.string().required(),
  MINIO_PORT: Joi.string().required(),
  MINIO_USE_SSL: Joi.boolean().required(),
  MINIO_ROOT_USER: Joi.string().required(),
  MINIO_ROOT_PASSWORD: Joi.string().required(),
  MINIO_BUCKET_NAME: Joi.string().required(),

  //REDIS
  REDIS_HOST: Joi.string().required(),
  REDIS_PORT: Joi.string().required(),

  //JWT
  JWT_ACCESS_SECRET: Joi.string().required(),
  JWT_REFRESH_SECRET: Joi.string().required(),
  JWT_RESET_SECRET: Joi.string().required(),
  JWT_ACCESS_TIME: Joi.string().required(),
  JWT_REFRESH_TIME: Joi.string().required(),

  //COOKIE
  COOKIE_SECRET: Joi.string().required(),

  //LOGS
  NOT_SAVE_IN_DB_CONTEXTS: Joi.string().required(),
  NOT_LOG_CONTEXTS: Joi.string().required(),
  NOT_LOG_HTTP_URLS: Joi.string().required(),

  //SENTRY
  SENTRY_DNS: Joi.string().required(),

  //GAME ENVIRONMENTS
  COMMON_ACC_BONUS: Joi.string().required(),
  PREMIUM_ACC_BONUS: Joi.string().required(),
  LOOT_BONUS_NUMBER: Joi.string().required(),
  REFERRAL_BONUS: Joi.string().required(),
  FARMING_INTERVAL: Joi.string().required(),
}).unknown(true);

export function validate(config: Record<string, unknown>) {
  const { error, value } = configSchema.validate(config, { abortEarly: false });

  if (error) {
    throw new Error(`Config validation error: ${error.message}`);
  }

  return value;
}
