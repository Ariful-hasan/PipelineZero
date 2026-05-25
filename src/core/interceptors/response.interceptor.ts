import { CallHandler, ExecutionContext, NestInterceptor } from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import type { Response } from 'express';

export interface ApiResponse<T> {
  statusCode: number;
  success: boolean;
  message: string;
  data: T;
}

export class ResponseInterceptor<T> implements NestInterceptor<ApiResponse<T>> {
  intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Observable<ApiResponse<T>> {
    const response = context.switchToHttp().getResponse<Response>();
    return next.handle().pipe(
      map((data) => ({
        statusCode: response.statusCode,
        success: true,
        message:
          response.statusCode >= 200 && response.statusCode < 300
            ? 'Operation successful'
            : 'Success',
        data: data,
      })),
    );
  }
}
