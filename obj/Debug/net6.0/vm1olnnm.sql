IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Notes] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [CreatedDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Notes] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220912185256_addNotesToDb', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'Title');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Notes] ALTER COLUMN [Title] nvarchar(150) NOT NULL;
GO

ALTER TABLE [Notes] ADD [CustomerId] int NOT NULL DEFAULT 0;
GO

CREATE TABLE [Customer] (
    [Id] int NOT NULL IDENTITY,
    [Login] nvarchar(max) NOT NULL,
    [Password] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([Id])
);
GO

CREATE INDEX [IX_Notes_CustomerId] ON [Notes] ([CustomerId]);
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230118082837_2405812nikitataissgay', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Customer_CustomerId];
GO

EXEC sp_rename N'[Notes].[CustomerId]', N'customerId', N'COLUMN';
GO

EXEC sp_rename N'[Notes].[IX_Notes_CustomerId]', N'IX_Notes_customerId', N'INDEX';
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Customer_customerId] FOREIGN KEY ([customerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230118083354_1234', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230127102204_UpdateTables', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Customer_customerId];
GO

DROP TABLE [Customer];
GO

EXEC sp_rename N'[Notes].[customerId]', N'UserId', N'COLUMN';
GO

EXEC sp_rename N'[Notes].[IX_Notes_customerId]', N'IX_Notes_UserId', N'INDEX';
GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'Title');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Notes] ALTER COLUMN [Title] nvarchar(max) NULL;
GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'Description');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [Notes] ALTER COLUMN [Description] nvarchar(max) NULL;
GO

CREATE TABLE [Users] (
    [Id] int NOT NULL IDENTITY,
    [Login] nvarchar(max) NOT NULL,
    [Password] nvarchar(max) NOT NULL,
    [DateOfCreate] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230128142904_UpdateDb', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Users_UserId];
GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'UserId');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [Notes] ALTER COLUMN [UserId] int NULL;
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230129212945_DeleteForeignKey', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Users_UserId];
GO

DROP INDEX [IX_Notes_UserId] ON [Notes];
GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'UserId');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [Notes] DROP COLUMN [UserId];
GO

ALTER TABLE [Users] ADD [ConfirmPassword] nvarchar(max) NOT NULL DEFAULT N'';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230130105723_updateTableUser', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Users]') AND [c].[name] = N'DateOfCreate');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Users] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [Users] ALTER COLUMN [DateOfCreate] datetime2 NOT NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230130155725_updateTableUser2', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] ADD [UserId] int NOT NULL DEFAULT 0;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230130160902_updateTableUser3', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230130171532_update', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE INDEX [IX_Notes_UserId] ON [Notes] ([UserId]);
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230201080842_UpdateTables1', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'Title');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [Notes] ALTER COLUMN [Title] nvarchar(max) NOT NULL;
ALTER TABLE [Notes] ADD DEFAULT N'' FOR [Title];
GO

ALTER TABLE [Notes] ADD [CountOfChanges] int NOT NULL DEFAULT 0;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230206115157_Add-CountOfChanges-InModel', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230206120442_Add-CountOfChanges-InModel2', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Users_UserId];
GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'UserId');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [Notes] ALTER COLUMN [UserId] int NULL;
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230206120714_Add-CountOfChanges-InModel3', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Users_UserId];
GO

DROP INDEX [IX_Notes_UserId] ON [Notes];
DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'UserId');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var8 + '];');
ALTER TABLE [Notes] ALTER COLUMN [UserId] int NOT NULL;
ALTER TABLE [Notes] ADD DEFAULT 0 FOR [UserId];
CREATE INDEX [IX_Notes_UserId] ON [Notes] ([UserId]);
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230206120942_Add-CountOfChanges-InModel4', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Users_UserId];
GO

DECLARE @var9 sysname;
SELECT @var9 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'UserId');
IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var9 + '];');
ALTER TABLE [Notes] ALTER COLUMN [UserId] int NULL;
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230206121032_Add-CountOfChanges-InModel5', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Notes] DROP CONSTRAINT [FK_Notes_Users_UserId];
GO

DROP INDEX [IX_Notes_UserId] ON [Notes];
DECLARE @var10 sysname;
SELECT @var10 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Notes]') AND [c].[name] = N'UserId');
IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [Notes] DROP CONSTRAINT [' + @var10 + '];');
ALTER TABLE [Notes] ALTER COLUMN [UserId] int NOT NULL;
ALTER TABLE [Notes] ADD DEFAULT 0 FOR [UserId];
CREATE INDEX [IX_Notes_UserId] ON [Notes] ([UserId]);
GO

ALTER TABLE [Notes] ADD CONSTRAINT [FK_Notes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230206121206_Add-CountOfChanges-InModel6', N'6.0.13');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var11 sysname;
SELECT @var11 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Users]') AND [c].[name] = N'ConfirmPassword');
IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [Users] DROP CONSTRAINT [' + @var11 + '];');
ALTER TABLE [Users] DROP COLUMN [ConfirmPassword];
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230320204138_updateUserTable', N'6.0.13');
GO

COMMIT;
GO

