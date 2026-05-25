import { Expose, Type } from 'class-transformer';
import { UserResponseDto } from '../../user/dto/user.response.dto';
import { WorkspaceDetailsPayload } from '../types/workspace-payload.types';

export class WorkspaceUsersDto {
  @Expose()
  @Type(() => UserResponseDto)
  user!: UserResponseDto;
  @Expose() role!: string; // Flattened from the pivot table for clean API usage
}

// export class JobApplicationDto {
//   @Expose() id!: string;
//   @Expose() candidateName!: string;
//   @Expose() status!: string;
//   @Expose() createdAt!: Date;
// }

// export class InvitationDto {
//   @Expose() id!: string;
//   @Expose() email!: string;
//   @Expose() role!: string;
//   @Expose() status!: string;
// }

export class WorkspaceDetailsResponseDto {
  @Expose() id!: string;
  @Expose() name!: string;
  @Expose() slug!: string;

  // Enforce nested serialization mapping
  @Expose()
  @Type(() => WorkspaceUsersDto)
  users!: WorkspaceUsersDto[];

  //   @Expose()
  //   @Type(() => JobApplicationDto)
  //   jobApplications!: JobApplicationDto[];

  //   @Expose()
  //   @Type(() => InvitationDto)
  //   invitations!: InvitationDto[];

  static fromEntity(
    entity: WorkspaceDetailsPayload,
  ): WorkspaceDetailsResponseDto {
    const dto = new WorkspaceDetailsResponseDto();
    dto.id = entity.id;
    dto.name = entity.name;
    dto.slug = entity.slug;

    dto.users = entity.users.map((item) => {
      const workspaceUserDto = new WorkspaceUsersDto();
      workspaceUserDto.role = item.role;

      const userDto = new UserResponseDto();
      userDto.id = item.user.id;
      userDto.email = item.user.email;
      userDto.name = item.user.name;
      userDto.isActive = item.user.isActive;
      userDto.createdAt = item.user.createdAt;
      userDto.updatedAt = item.user.updatedAt;

      workspaceUserDto.user = userDto;

      return workspaceUserDto;
    });

    return dto;
  }
}
