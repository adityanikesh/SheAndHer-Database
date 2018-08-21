use sheandher_db;
-- ---------------------------------------------------------------------------------------------------------------
-- Spring Security Database Schema
-- ---------------------------------------------------------------------------------------------------------------
drop table if exists user_roles;
create table user_roles (
user_role_id bigint(11) not null auto_increment,
user_id bigint(11) not null,
role varchar(45) not null,
create_time timestamp null,
update_time timestamp null,
primary key (user_role_id),
unique key uk_userid_role(role,user_id),
constraint fk_userid foreign key (user_id) references users (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

drop table if exists users;
create table users (
user_id bigint(11) not null auto_increment,
first_name varchar(30) not null,
last_name varchar(30) not null,
email varchar(70) not null,
country varchar(30),
phone varchar(30),
username varchar(25) not null,
password varchar(60) not null,
role_id bigint(11) not null,
enabled bit(1) not null,
account_non_expired bit(1),
account_non_locked bit(1),
credentials_non_expired bit(1),
create_time timestamp null,
update_time timestamp null,
primary key (user_id),
constraint fk_roleid foreign key(role_id)references roles (role_id),
unique key (username)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


drop table if exists roles;
create table roles (
role_id bigint(11)not null auto_increment,
role_name varchar(25) not null,
authority varchar(256) not null,
primary key(role_id),
create_time timestamp null,
update_time timestamp null,
unique key(role)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


drop table if exists user_roles;
create table user_roles(
user_id bigint(11) not null,
role_id bigint(11) not null,
create_time timestamp null,
update_time timestamp null,
primary key (user_id, role_id),
foreign key fk_user (user_id) references users (user_id)
	on delete cascade
    on update cascade,
foreign key fk_role (role_id) references roles (role_id)
	on delete cascade
    on update cascade
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


drop table if exists oauth_client_details;
create table oauth_client_details (
  client_id VARCHAR(256) PRIMARY KEY,
  resource_ids VARCHAR(256),
  client_secret VARCHAR(256),
  scope VARCHAR(256),
  authorized_grant_types VARCHAR(256),
  web_server_redirect_uri VARCHAR(256),
  authorities VARCHAR(256),
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additional_information VARCHAR(4096),
  autoapprove VARCHAR(256)
);

drop table if exists oauth_client_token;
create table oauth_client_token (
  token_id VARCHAR(256),
  token LONG VARBINARY,
  authentication_id VARCHAR(256) PRIMARY KEY,
  user_name VARCHAR(256),
  client_id VARCHAR(256)
);

drop table if exists oauth_access_token;
create table if not exists oauth_access_token (
    token_id VARCHAR(256),
    token LONG VARBINARY,
    authentication_id VARCHAR(256) PRIMARY KEY,
    user_name VARCHAR(256),
    client_id VARCHAR(256),
    authentication LONG VARBINARY,
    refresh_token VARCHAR(256)
  );
  
drop table if exists oauth_refresh_token;
create table oauth_refresh_token (
  token_id VARCHAR(256),
  token LONG VARBINARY,
  authentication LONG VARBINARY
);

drop table if exists oauth_code;
create table oauth_code (
  code VARCHAR(256), authentication LONG VARBINARY
);
 
drop table if exists oauth_approvals;
create table oauth_approvals (
	userId VARCHAR(256),
	clientId VARCHAR(256),
	scope VARCHAR(256),
	status VARCHAR(10),
	expiresAt TIMESTAMP null,
	lastModifiedAt TIMESTAMP null
);