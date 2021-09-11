/*
\! echo "                                      ************    Products Table   ***************"
Select Name, Id, Maintenance, Ownership, Deleted_at from Products;
*/
\! echo "                                      ************    Applications Table   ***************"
Select Name, Id, Maintenance, Product_Id, Ownership, Deleted_at from Applications;
\! echo "                                      ************    Services Table   ***************"
Select Name, Id, Application_Id, Status_Type, Maintenance, Current_Status, Ownership, Deleted_at from Services;
\! echo "                                      ************    Maintenance_windows Table - all   ***************"
Select Id, Resource_type, Resource_id, start_time, Deleted_at, end_time from Maintenance_windows where Deleted_at is not null;
\! echo "                                      ************    Maintenance_windows Table - not deleted_at   ***************"
Select Id, Resource_type, Resource_id, start_time, Deleted_at, end_time from Maintenance_windows where Deleted_at is null;