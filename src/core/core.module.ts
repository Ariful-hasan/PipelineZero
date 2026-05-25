import { Global, Module } from '@nestjs/common';
import { UtilService } from './utils/util/util.service';

@Global()
@Module({
  providers: [UtilService],
  exports: [UtilService],
})
export class CoreModule {}
