/********************************
    Created by: Joshua Alzate
    Created on: 2020-02-03
    Add constraint to prevent creation of course dates
********************************/

if((SELECT Count(*)  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME ='CourseDatesLU_ValidateDates') = 0)
begin
	alter table [CourseDatesLU] add constraint CourseDatesLU_ValidateDates check ([DateFrom] < [DateTo]);
end