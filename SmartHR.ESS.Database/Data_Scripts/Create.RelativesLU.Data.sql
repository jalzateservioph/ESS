IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Father')
    INSERT INTO [RelativesLU] SELECT 'Father'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Mother')
    INSERT INTO [RelativesLU] SELECT 'Mother'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Brother')
    INSERT INTO [RelativesLU] SELECT 'Brother'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Sister')
    INSERT INTO [RelativesLU] SELECT 'Sister'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'GrandMother')
    INSERT INTO [RelativesLU] SELECT 'GrandMother'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'GrandFather')
    INSERT INTO [RelativesLU] SELECT 'GrandFather'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Son')
    INSERT INTO [RelativesLU] SELECT 'Son'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Daughter')
    INSERT INTO [RelativesLU] SELECT 'Daughter'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Uncle')
    INSERT INTO [RelativesLU] SELECT 'Uncle'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Aunt')
    INSERT INTO [RelativesLU] SELECT 'Aunt'
IF NOT EXISTS(SELECT 1 FROM [RelativesLU] WHERE [Relatives] = 'Guardian')
    INSERT INTO [RelativesLU] SELECT 'Guardian'
GO