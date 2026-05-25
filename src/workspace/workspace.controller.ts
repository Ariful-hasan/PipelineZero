import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { WorkspaceService } from './workspace.service';
import { AuthGuard } from '@nestjs/passport';
import { CreateWorkspaceDto } from './dto/create-workspace.dto';
import { WorkspaceDetailsResponseDto } from './dto/workspace-response.dto';

@Controller('workspace')
@UseGuards(AuthGuard('jwt'))
export class WorkspaceController {
  constructor(private readonly workspaceService: WorkspaceService) {}

  @Post()
  async createWorkspace(
    @Body() createWorkspaceDto: CreateWorkspaceDto,
    @Req() req: any,
  ) {
    return await this.workspaceService.create(createWorkspaceDto, req.user.id);
  }

  @Get()
  async getWorkspaces() {
    // Implementation for retrieving workspaces
  }

  @Get(':id')
  async getWorkspaceById(@Param('id') id: string) {
    const workspace = await this.workspaceService.findById(id);

    return WorkspaceDetailsResponseDto.fromEntity(workspace);
  }

  // @Put(':id')
  // async updateWorkspace(@Param('id') id: string) {
  //     // Implementation for updating a workspace
  // }

  // @Delete(':id')
  // async deleteWorkspace(@Param('id') id: string) {
  //     // Implementation for deleting a workspace
  // }
}
