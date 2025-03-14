-- Customer table
create table customer 
(
  customerid  number(10),
  firstname   varchar2(50) not null,
  lastname    varchar2(50) not null,
  dateofbirth date not null,
  address     varchar2(100) not null,
  city        varchar2(50) not null,
  state       varchar2(2) not null,
  zip         varchar2(10) not null,
  phone       varchar2(20) not null,
  email       varchar2(100) unique not null,
  constraint pk_custid primary key (customerid)
);

-- Insert data into Customer table
insert into customer
  (customerid, firstname, lastname, dateofbirth, address, city, state, zip, phone, email)
values
  (1,'John','Doe',to_date('1980-06-15', 'YYYY-MM-DD'),'123 Main St','New York','NY','10001','1234567890','john.doe@email.com');
insert into customer
  (customerid, firstname, lastname, dateofbirth, address, city, state, zip, phone, email) 
values   
  (2,'Jane','Smith',TO_DATE('1990-03-10', 'YYYY-MM-DD'),'456 Elm St','Los Angeles','CA','90001','2345678901','jane.smith@email.com');
  
insert into customer
  (customerid, firstname, lastname, dateofbirth, address, city, state, zip, phone, email) 
values  
  (3,'Alice','Johnson',TO_DATE('1975-10-20', 'YYYY-MM-DD'),'789 Oak St','Chicago','IL','60601','3456789012', 'alice.johnson@email.com');

-- Subscription Plan table
create table SubscriptionPlan 
(
  planid       number(10),
  planname     varchar2(100) not null,
  monthlyfee   number(10, 2) not null,
  voiceminutes number(10) not null,
  smslimit     number(10) not null,
  datalimit    number(10) not null,
  constraint   pk_planid primary key (planid)
);

insert into SubscriptionPlan 
 (PlanID, PlanName, MonthlyFee, VoiceMinutes, SMSLimit, DataLimit) 
values
 (1, 'Basic', 19.99, 300, 100, 1024);
insert into SubscriptionPlan 
 (PlanID, PlanName, MonthlyFee, VoiceMinutes, SMSLimit, DataLimit) 
values(2, 'Standard', 29.99, 1000, 500, 5120);
insert into SubscriptionPlan 
 (PlanID, PlanName, MonthlyFee, VoiceMinutes, SMSLimit, DataLimit) 
values(3, 'Premium', 49.99, 5000, 2000, 10240);


-- Device table
create table device 
(
  deviceid       number(10),
  customerid     number(10) not null,
  devicename     varchar2(100) not null,
  devicetype     varchar2(50) not null,
  imei           varchar2(50) unique not null,
  simnumber      varchar2(50) unique not null,
  activationdate date not null,
  constraint   pk_deviceid primary key (deviceid),
  foreign key (customerid) references customer(customerid)
);

insert into Device 
 (DeviceID, CustomerID, DeviceName, DeviceType, IMEI, SIMNumber, ActivationDate) 
values
 (1, 1, 'Phone Model 1', 'Smartphone', '123456789012345', '111222333444', TO_DATE('2020-01-01', 'YYYY-MM-DD'));
insert into Device 
 (DeviceID, CustomerID, DeviceName, DeviceType, IMEI, SIMNumber, ActivationDate) 
values 
(2, 2, 'Phone Model 2', 'Smartphone', '234567890123456', '222333444555', TO_DATE('2021-03-15', 'YYYY-MM-DD'));
insert into Device 
 (DeviceID, CustomerID, DeviceName, DeviceType, IMEI, SIMNumber, ActivationDate) 
values
(3, 3, 'Phone Model 3', 'Smartphone', '345678901234567', '333444555666', TO_DATE('2019-10-10', 'YYYY-MM-DD'));

-- Call Record table
create table CallRecord 
(
  callid         number(10),
  customerid     number(10) not null,
  calldate       date not null,
  starttime      timestamp not null,
  endtime        timestamp not null,
  duration       number(10) not null,
  callednumber   varchar2(20) not null,
  calltype       varchar2(50) not null,
  cost           number(10, 2) not null,
  constraint   pk_callid primary key (callid),
  foreign key (customerid) references customer(customerid)
);

-- SMS Record table
create table SMSRecord 
(
  smsid          number(10),
  customerid     number(10) not null,
  messagedate    date not null,
  sendernumber   varchar2(20) not null,
  receivernumber varchar2(20) not null,
  messagetype    varchar2(50) not null,
  cost           number(10, 2) not null,
  constraint     pk_smsid primary key (smsid),
  foreign key (customerid) references customer(customerid)
);

insert into CallRecord 
 (CallID, CustomerID, CallDate, StartTime, EndTime, Duration, CalledNumber, CallType, Cost)
values
 (1, 1, TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-05-01 09:05:00', 'YYYY-MM-DD HH24:MI:SS'), 5, '5551234567', 'Local', 0.25);
insert into CallRecord 
 (CallID, CustomerID, CallDate, StartTime, EndTime, Duration, CalledNumber, CallType, Cost)
values 
 (2, 1, TO_DATE('2023-05-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-05-02 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-05-02 15:45:00', 'YYYY-MM-DD HH24:MI:SS'),7,'5551234567', 'Local', 0.25);


-- Data Usage Record table
create table DataUsageRecord 
( 
  dataid          number(10),
  customerid      number(10) not null,
  usagedate       date not null,
  dataused        number(10) not null,
  datasessiontype varchar2(50) not null,
  cost number(10, 2) not null,
  constraint     pk_dataid primary key (dataid),
  foreign key (customerid) references customer(customerid)
);

-- Billing table
create table Billing 
(
  BillingID      number(10),
  CustomerID     number(10) not null,
  BillDate       date not null,
  TotalCallsCost number(10,2) not null,
  TotalSMSCost   number(10,2) not null,
  TotalDataCost  number(10,2) not null,
  TotalAmount    number(10, 2) not null,
  DueDate        date not null,
  constraint     pk_BillingID primary key (BillingID),
  foreign key (CustomerID) references Customer(CustomerID)
);

-- Payment table
create table Payment 
( 
  PaymentID     number,
  BillingID     number not null,
  PaymentDate   date not null,
  PaymentMethod varchar2(50),
  AmountPaid    number(10, 2) not null,
  PaymentStatus varchar2(20) not null,
  constraint     pk_PaymentID primary key (PaymentID),
  foreign key (BillingID) references Billing(BillingID)
);



-------------------------------------------------------Heller------------------------------------------------------------

--1.Bütün müştərilərin adını, soyadını və e-poçt ünvanını əldə edən sorğunu yazın (Customers).

SELECT FIRSTNAME,LASTNAME,EMAIL
FROM Customer;


--2.Aylıq haqqı 50 dollardan az olan bütün abunə planlarının məlumatlarını ekrana çıxardan sorğunu yazın (SubscriptionPlan).

SELECT *
FROM SubscriptionPlan
WHERE MONTHLYFEE < 50;


--3.Hər bir müştəri üçün orta zəng müddətini tapın.

SELECT cr.CUSTOMERID, AVG(cr.DURATION) AS Average_Call_Duration
FROM CallRecord cr
GROUP BY cr.CUSTOMERID;


---4.2023-cü ilin yanvar ayında hər bir müştəri tərəfindən göndərilən SMS-lərin sayını hesablayın.

SELECT sr.CUSTOMERID, COUNT(*) AS SMS_Count
FROM SMSRECORD sr
WHERE EXTRACT(YEAR FROM sr.MESSAGEDATE) = 2023 AND EXTRACT(MONTH FROM sr.MESSAGEDATE) = 1
GROUP BY sr.CUSTOMERID;


--5.Müştəri ID 123-ə məxsus bütün cihazlar üçün cihazın adını və aktivləşdirmə tarixini əldə edin.

SELECT d.DEVICENAME, d.ACTIVATIONDATE
FROM device d
WHERE d.CUSTOMERID = 123;


--6.2023-cü ilin fevral ayında hər bir müştəri üçün bütün data istifadəsi sesiyalarının ümumi dəyərini hesablayın. 

SELECT d.CUSTOMERID, SUM(d.DATAUSED) AS Total_Data_Usage_Value
FROM DataUsageRecord d
WHERE EXTRACT(YEAR FROM d.USAGEDATE) = 2023
  AND EXTRACT(MONTH FROM d.USAGEDATE) = 2
GROUP BY d.CUSTOMERID;


--7.CallRecord cədvəlində bütün zəng edilmiş nömrələrin telefon nömrələrini dublikatsız məlumatları ekrana çıxardan sorğu yazın.

select  distinct CALLEDNUMBER from  callrecord;

--8.31 may 2023-cü il tarixdə ödəmə tarixi olan bütün müştərilərin adlarını əldə edin.

SELECT c.FIRSTNAME
FROM Customer c
INNER JOIN Billing b ON c.CustomerID = b.CUSTOMERID
INNER JOIN Payment p ON b.BILLINGID = p.BILLINGID
WHERE p.PAYMENTDATE = TO_DATE('2023-05-31', 'YYYY-MM-DD');


---9."893" ilə başlayan SİM nömrəsi olan bütün cihazlar üçün müştəri ID və cihaz növünü tapın.

SELECT d.CUSTOMERID AS CustomerID,
       d.DEVICETYPE AS DeviceType
FROM Device d
WHERE d.DEVICEID LIKE '893%';


--10.Ödəniş cədvəlində hər bir müştərinin ödədiyi ümumi məbləği hesablayın.

SELECT c.CustomerID AS CustomerID,
       SUM(p.AMOUNTPAID) AS TotalAmountPaid
FROM Customer c
INNER JOIN Billing b ON c.CustomerID = b.CUSTOMERID
INNER JOIN Payment p ON b.BILLINGID = p.BILLINGID
GROUP BY c.CustomerID;




