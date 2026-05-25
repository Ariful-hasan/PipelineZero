import { Injectable } from '@nestjs/common';
import * as crypto from 'crypto';

@Injectable()
export class UtilService {
  /**
   * Generates a URL-safe unique slug based on a string name and a contextual ID.
   */
  generateSlug(name: string, contextId: string): string {
    const base = name
      .toLowerCase()
      .trim()
      .replace(/[^a-z0-9\s-]/g, '')
      .replace(/\s+/g, '-')
      .slice(0, 40);

    const uniquePart = crypto
      .createHash('sha256')
      .update(contextId + Date.now())
      .digest('hex')
      .slice(0, 6);

    return `${base}-${uniquePart}`;
  }
}
