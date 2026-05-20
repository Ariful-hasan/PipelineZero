workspace
-----------------
id        : serial PK
name      : varchar(255) not null
slug      : varchar(255) not null UNIQUE
is_active : boolean default true
createdAt : timestamp
updatedAt : timestamp

user
-----------------
id                    : bigserial PK
name                  : varchar(255) not null
email                 : varchar(255) not null UNIQUE
password              : varchar(255) not null
phone                 : varchar(20) default null
is_active             : boolean default false
two_factor_type       : char(3) default null
two_factor_enabled_at : timestamp default null
createdAt             : timestamp
updatedAt             : timestamp

workspace_user (Renamed for standard NestJS naming)
-----------------
id           : serial PK
workspace_id : int FK -> workspace.id
user_id      : bigint FK -> user.id
role         : smallint not null -- [100=owner, 90=admin, 80=member, 70=viewer]
status       : smallint default 2 -- [0=inactive, 1=active, 2=invited, 3=removed]
createdAt    : timestamp default current_timestamp
updatedAt    : timestamp default current_timestamp

workspace_invitation
---------------------
id                 : serial PK
workspace_id       : int FK -> workspace.id
invited_by_user_id : bigint FK -> user.id
email              : varchar(255) not null -- The target email address
role               : smallint not null     -- [90=admin, 80=member, 70=viewer]
token              : varchar(255) not null UNIQUE -- Secure hash used in the email invitation link
status             : smallint default 0    -- [0=pending, 1=accepted, 2=revoked, 3=expired]
expires_at         : timestamp not null    -- Usually current_timestamp + 48 hours
created_at         : timestamp default current_timestamp
accepted_at        : timestamp default null

job_application
-----------------
id                 : serial PK
workspace_id       : int FK -> workspace.id
created_by_user_id : bigint FK -> user.id -- Track who created it, but query via workspace_id
company            : varchar(255) not null
title              : varchar(255) not null
description        : text default null
status             : smallint not null -- [0=saved, 1=applied, 2=screening, 3=interview, 4=offer, 5=rejected, 6=withdrawn]
source             : text default null
location           : varchar(255) default null
seniority_level    : varchar(50) not null
employment_type    : varchar(50) not null
salary             : int default null
currency           : char(3) default null
appliedAt          : timestamp default null
createdAt          : timestamp default current_timestamp
updatedAt          : timestamp default current_timestamp
deleted_at         : timestamp default null -- For your Soft Delete requirement

job_status_history
-----------------
id                 : serial PK -- Added unique identifier
job_id             : int FK -> job_application.id
from_status        : smallint not null
to_status          : smallint not null
changed_by_user_id : bigint FK -> user.id
comment            : text default null
changedAt          : timestamp default current_timestamp