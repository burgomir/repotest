import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module';
import 'reflect-metadata';
import * as compression from 'compression';
import * as Sentry from '@sentry/node';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { nodeProfilingIntegration } from '@sentry/profiling-node';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { ConfigService } from '@nestjs/config';
import {
  ClassSerializerInterceptor,
  LogLevel,
  ValidationPipe,
} from '@nestjs/common';
import fastifyCookie from '@fastify/cookie';
// import fastifyCors from '@fastify/cors';
import fastifyCsrfProtection from '@fastify/csrf-protection';
import fastifyHelmet from '@fastify/helmet';
import multipart from '@fastify/multipart';
import CustomLogger from './libs/logger/helpers/customLogger';
import { RedisIoAdapter } from './components/socket/webSocket.config';

async function bootstrap() {
  const isProduction = process.env.NODE_ENV === 'production';
  const logLevels: LogLevel[] = isProduction
    ? ['error', 'warn', 'log']
    : ['error', 'warn', 'log', 'debug', 'verbose'];
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter(),
    {
      logger: logLevels,
    },
  );

  app.useWebSocketAdapter(new RedisIoAdapter(app));

  const configService = app.get(ConfigService);
  const port = configService.getOrThrow<number>('PORT');
  Sentry.init({
    dsn: configService.getOrThrow<'string'>('SENTRY_DNS'),
    integrations: [
      new Sentry.Integrations.Http({ tracing: true }),

      nodeProfilingIntegration(),
    ],

    tracesSampleRate: 1.0,

    profilesSampleRate: 1.0,
  });

  app.use(Sentry.Handlers.requestHandler());

  app.use(Sentry.Handlers.tracingHandler());

  const config = new DocumentBuilder()
    .setTitle('Bee verse server')
    .setDescription('Bee verse server api documentation')
    .setVersion('1.0')
    .addTag('Bee_Verse')
    .addServer('/api')
    .setContact('David', 'https://t.me/Davut_7', '20031212dawut@gmail.com')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config, {
    ignoreGlobalPrefix: false,
  });

  if (process.env.NODE_ENV === 'development') {
    SwaggerModule.setup('api/docs', app, document, { useGlobalPrefix: true });
  }

  app.register(fastifyHelmet);
  app.register(fastifyCsrfProtection, { cookieOpts: { signed: true } });
  app.enableCors({
    origin: (origin, callback) => {
      const allowedOrigins = [
        'https://beeverse.zapto.org',
        'http://beeverse.zapto.org',
      ];

      if (
        !origin ||
        allowedOrigins.some((allowedOrigin) => origin.startsWith(allowedOrigin))
      ) {
        callback(null, true);
      } else {
        callback(new Error('Not allowed by CORS'));
      }
    },
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    allowedHeaders: 'Content-Type,Authorization',
    credentials: true,
    optionsSuccessStatus: 204,
    preflightContinue: false,
  });

  app.register(multipart);
  await app.register(fastifyCookie, {
    secret: configService.getOrThrow<'string'>('COOKIE_SECRET'),
  });

  app.use(compression());
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      transformOptions: { enableImplicitConversion: true },
    }),
  );
  app.useGlobalInterceptors(new ClassSerializerInterceptor(app.get(Reflector)));
  app.setGlobalPrefix('api');

  await app.listen(port, '0.0.0.0', () => {
    console.log(`Your server is listening on port ${port}`);
  });

  app.useLogger(app.get(CustomLogger, { strict: false }));
  app.use(Sentry.Handlers.tracingHandler());
}

bootstrap();
