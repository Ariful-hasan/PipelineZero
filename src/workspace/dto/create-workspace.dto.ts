import { IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class CreateWorkspaceDto {
  @IsString()
  @IsNotEmpty({ message: 'Workspace name must not be empty' })
  name!: string;

  @IsOptional()
  @IsString()
  description?: string;

  userId?: string; // This will be set in the service layer, not provided by the client`
}
