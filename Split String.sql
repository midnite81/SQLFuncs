SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[SPLIT_STRING]
    (
      @LIST NTEXT ,
      @DELIMITER NCHAR(1) = N','
    )
RETURNS @TBL TABLE
    (
      ID INT IDENTITY ,
      COLUMN1 VARCHAR(1000)
    )
AS 
    BEGIN
        DECLARE @POS INT ,
            @TEXTPOS INT ,
            @CHUNKLEN SMALLINT ,
            @TMPSTR NVARCHAR(4000) ,
            @LEFTOVER NVARCHAR(4000) ,
            @TMPVAL NVARCHAR(4000)

        SET @TEXTPOS = 1
        SET @LEFTOVER = ''
        WHILE @TEXTPOS <= DATALENGTH(@LIST) / 2 
            BEGIN
                SET @CHUNKLEN = 4000 - DATALENGTH(@LEFTOVER) / 2
                SET @TMPSTR = @LEFTOVER + SUBSTRING(@LIST, @TEXTPOS, @CHUNKLEN)
                SET @TEXTPOS = @TEXTPOS + @CHUNKLEN

                SET @POS = CHARINDEX(@DELIMITER, @TMPSTR)

                WHILE @POS > 0 
                    BEGIN
                        SET @TMPVAL = LTRIM(RTRIM(LEFT(@TMPSTR, @POS - 1)))
                        INSERT  @TBL
                                ( COLUMN1 )
                        VALUES  ( @TMPVAL )
                        SET @TMPSTR = SUBSTRING(@TMPSTR, @POS + 1,
                                                LEN(@TMPSTR))
                        SET @POS = CHARINDEX(@DELIMITER, @TMPSTR)
                    END

                SET @LEFTOVER = @TMPSTR
            END

        INSERT  @TBL
                ( COLUMN1 )
        VALUES  ( LTRIM(RTRIM(@LEFTOVER)) )
        RETURN
    END