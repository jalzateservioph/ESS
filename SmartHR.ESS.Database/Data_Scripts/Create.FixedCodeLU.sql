IF NOT EXISTS(SELECT 1 FROM [FixedLU] WHERE [Fixed] = '0700H-1600H')
    INSERT INTO [FixedLU] VALUES ('0700H-1600H')
IF NOT EXISTS(SELECT 1 FROM [FixedLU] WHERE [Fixed] = '0815H-1715H')
    INSERT INTO [FixedLU] VALUES ('0815H-1715H')
GO