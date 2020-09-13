/**************************************************

	Created By: Joshua Alzate
	Created On: 2020-03-06 17:08
	Description: Added constraint rule to prevent delete from CourseNameLU if used

**************************************************/

ALTER TABLE [dbo].[TrainingEventLU] DROP CONSTRAINT [FK_TrainingEventLU_CourseNameLU]
GO

ALTER TABLE [dbo].[TrainingEventLU]  WITH CHECK ADD  CONSTRAINT [FK_TrainingEventLU_CourseNameLU] FOREIGN KEY([CourseName])
REFERENCES [dbo].[CourseNameLU] ([CourseName])
ON UPDATE CASCADE
ON DELETE NO ACTION
GO