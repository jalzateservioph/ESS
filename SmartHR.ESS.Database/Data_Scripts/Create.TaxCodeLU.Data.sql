IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'S') 
    INSERT INTO [TaxCodeLU] VALUES ('S')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'S1')
    INSERT INTO [TaxCodeLU] VALUES ('S1')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'S2')
    INSERT INTO [TaxCodeLU] VALUES ('S2')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'S3')
    INSERT INTO [TaxCodeLU] VALUES ('S3')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'S4')
    INSERT INTO [TaxCodeLU] VALUES ('S4')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'M') 
    INSERT INTO [TaxCodeLU] VALUES ('M')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'M1')
    INSERT INTO [TaxCodeLU] VALUES ('M1')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'M2')
    INSERT INTO [TaxCodeLU] VALUES ('M2')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'M3')
    INSERT INTO [TaxCodeLU] VALUES ('M3')
IF NOT EXISTS(SELECT 1 FROM [TaxCodeLU] WHERE [TaxCode] = 'M4')
    INSERT INTO [TaxCodeLU] VALUES ('M4')

GO