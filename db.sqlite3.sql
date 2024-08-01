BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_assessment" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_assignment" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_customuser" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"email"	varchar(254) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_institute" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL UNIQUE,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	"logo"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_qualifyingtest" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_subcourse" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	"order"	integer unsigned NOT NULL CHECK("order" >= 0),
	"course_id"	bigint NOT NULL,
	"prerequisite_assessment_id"	bigint,
	FOREIGN KEY("prerequisite_assessment_id") REFERENCES "frontend_assessment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("course_id") REFERENCES "frontend_course"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_topic" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	"url"	varchar(200) NOT NULL,
	"order"	integer unsigned NOT NULL CHECK("order" >= 0),
	"prerequisite_assignment_id"	bigint,
	"subcourse_id"	bigint NOT NULL,
	FOREIGN KEY("subcourse_id") REFERENCES "frontend_subcourse"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("prerequisite_assignment_id") REFERENCES "frontend_assignment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "frontend_customuser"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_assessments_completed" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"assessment_id"	bigint NOT NULL,
	FOREIGN KEY("assessment_id") REFERENCES "frontend_assessment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_assignments_completed" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"assignment_id"	bigint NOT NULL,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("assignment_id") REFERENCES "frontend_assignment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_courses" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"course_id"	bigint NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "frontend_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_institutes" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"institute_id"	bigint NOT NULL,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("institute_id") REFERENCES "frontend_institute"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_qualifying_tests_completed" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"qualifyingtest_id"	bigint NOT NULL,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("qualifyingtest_id") REFERENCES "frontend_qualifyingtest"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_subcourses" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"subcourse_id"	bigint NOT NULL,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("subcourse_id") REFERENCES "frontend_subcourse"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_userprogress_topics" (
	"id"	integer NOT NULL,
	"userprogress_id"	bigint NOT NULL,
	"topic_id"	bigint NOT NULL,
	FOREIGN KEY("topic_id") REFERENCES "frontend_topic"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("userprogress_id") REFERENCES "frontend_userprogress"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_testrequirement" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	"from_course_id"	bigint NOT NULL,
	"to_course_id"	bigint NOT NULL,
	FOREIGN KEY("from_course_id") REFERENCES "frontend_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("to_course_id") REFERENCES "frontend_course"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_courseroom" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"description"	text NOT NULL,
	"course_id"	bigint NOT NULL UNIQUE,
	FOREIGN KEY("course_id") REFERENCES "frontend_course"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_courseroom_members" (
	"id"	integer NOT NULL,
	"courseroom_id"	bigint NOT NULL,
	"customuser_id"	bigint NOT NULL,
	FOREIGN KEY("courseroom_id") REFERENCES "frontend_courseroom"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("customuser_id") REFERENCES "frontend_customuser"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_course_institutes" (
	"id"	integer NOT NULL,
	"course_id"	bigint NOT NULL,
	"institute_id"	bigint NOT NULL,
	FOREIGN KEY("institute_id") REFERENCES "frontend_institute"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("course_id") REFERENCES "frontend_course"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_course" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"description"	text NOT NULL,
	"qualifying_test_id"	bigint,
	FOREIGN KEY("qualifying_test_id") REFERENCES "frontend_qualifyingtest"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-08-01 01:16:48.550433');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-08-01 01:16:48.577434');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2024-08-01 01:16:48.593439');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2024-08-01 01:16:48.611951');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2024-08-01 01:16:48.628951');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2024-08-01 01:16:48.651113');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2024-08-01 01:16:48.666633');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2024-08-01 01:16:48.681642');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2024-08-01 01:16:48.694129');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2024-08-01 01:16:48.717633');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2024-08-01 01:16:48.722635');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2024-08-01 01:16:48.734674');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2024-08-01 01:16:48.751638');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2024-08-01 01:16:48.765546');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2024-08-01 01:16:48.779576');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2024-08-01 01:16:48.795564');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2024-08-01 01:16:48.808754');
INSERT INTO "django_migrations" VALUES (18,'frontend','0001_initial','2024-08-01 01:16:48.895827');
INSERT INTO "django_migrations" VALUES (19,'sessions','0001_initial','2024-08-01 01:16:48.907336');
INSERT INTO "django_admin_log" VALUES (1,'2024-08-01 01:19:20.954318','1','IIT Madras','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (2,'2024-08-01 01:19:52.782372','2','IIT Delhi','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (3,'2024-08-01 01:20:09.524175','3','Harvard','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (4,'2024-08-01 01:20:26.477142','4','Panjab University','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (5,'2024-08-01 01:22:28.312608','1','Data Science Qualifier Test','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (6,'2024-08-01 01:22:31.851482','1','Data Science and Its Applications(Foundation)','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (7,'2024-08-01 01:23:47.436192','2','Electronics Qualifier','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (8,'2024-08-01 01:23:49.769734','2','Electronic Systems','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (9,'2024-08-01 01:25:06.619947','3','Data Science Advanced Qualifier','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (10,'2024-08-01 01:25:11.202004','3','Data Science for Business','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (11,'2024-08-01 01:26:15.485472','1','Mathematics 1','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (12,'2024-08-01 01:26:45.981966','2','Statistics 1','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (13,'2024-08-01 01:27:33.374475','1','Mathematics 1','[]',13,1,2);
INSERT INTO "django_admin_log" VALUES (14,'2024-08-01 01:29:00.931287','1','Maths 1 to Maths 2','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (15,'2024-08-01 01:29:04.276531','3','Mathematics 2','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (16,'2024-08-01 01:30:20.564409','1','Maths 1 Assigment 1','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (17,'2024-08-01 01:31:44.789214','1','Mathematics 1 - Natural Numbers and Their Operations','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" VALUES (18,'2024-08-01 01:32:12.277455','2','Mathematics 1 - Rational Numbers','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" VALUES (19,'2024-08-01 01:32:21.281896','1','Mathematics 1','[]',13,1,2);
INSERT INTO "django_admin_log" VALUES (20,'2024-08-01 01:32:25.730741','3','Mathematics 2','[{"changed": {"fields": ["Order"]}}]',13,1,2);
INSERT INTO "django_admin_log" VALUES (21,'2024-08-01 01:32:34.538861','3','Mathematics 2','[]',13,1,2);
INSERT INTO "django_admin_log" VALUES (22,'2024-08-01 01:32:43.455529','3','Data Science for Business','[]',9,1,2);
INSERT INTO "django_admin_log" VALUES (23,'2024-08-01 01:35:25.809028','2','rohan','[{"added": {}}]',4,1,1);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'frontend','assessment');
INSERT INTO "django_content_type" VALUES (8,'frontend','assignment');
INSERT INTO "django_content_type" VALUES (9,'frontend','course');
INSERT INTO "django_content_type" VALUES (10,'frontend','customuser');
INSERT INTO "django_content_type" VALUES (11,'frontend','institute');
INSERT INTO "django_content_type" VALUES (12,'frontend','qualifyingtest');
INSERT INTO "django_content_type" VALUES (13,'frontend','subcourse');
INSERT INTO "django_content_type" VALUES (14,'frontend','topic');
INSERT INTO "django_content_type" VALUES (15,'frontend','userprogress');
INSERT INTO "django_content_type" VALUES (16,'frontend','testrequirement');
INSERT INTO "django_content_type" VALUES (17,'frontend','courseroom');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_assessment','Can add assessment');
INSERT INTO "auth_permission" VALUES (26,7,'change_assessment','Can change assessment');
INSERT INTO "auth_permission" VALUES (27,7,'delete_assessment','Can delete assessment');
INSERT INTO "auth_permission" VALUES (28,7,'view_assessment','Can view assessment');
INSERT INTO "auth_permission" VALUES (29,8,'add_assignment','Can add assignment');
INSERT INTO "auth_permission" VALUES (30,8,'change_assignment','Can change assignment');
INSERT INTO "auth_permission" VALUES (31,8,'delete_assignment','Can delete assignment');
INSERT INTO "auth_permission" VALUES (32,8,'view_assignment','Can view assignment');
INSERT INTO "auth_permission" VALUES (33,9,'add_course','Can add course');
INSERT INTO "auth_permission" VALUES (34,9,'change_course','Can change course');
INSERT INTO "auth_permission" VALUES (35,9,'delete_course','Can delete course');
INSERT INTO "auth_permission" VALUES (36,9,'view_course','Can view course');
INSERT INTO "auth_permission" VALUES (37,10,'add_customuser','Can add custom user');
INSERT INTO "auth_permission" VALUES (38,10,'change_customuser','Can change custom user');
INSERT INTO "auth_permission" VALUES (39,10,'delete_customuser','Can delete custom user');
INSERT INTO "auth_permission" VALUES (40,10,'view_customuser','Can view custom user');
INSERT INTO "auth_permission" VALUES (41,11,'add_institute','Can add institute');
INSERT INTO "auth_permission" VALUES (42,11,'change_institute','Can change institute');
INSERT INTO "auth_permission" VALUES (43,11,'delete_institute','Can delete institute');
INSERT INTO "auth_permission" VALUES (44,11,'view_institute','Can view institute');
INSERT INTO "auth_permission" VALUES (45,12,'add_qualifyingtest','Can add qualifying test');
INSERT INTO "auth_permission" VALUES (46,12,'change_qualifyingtest','Can change qualifying test');
INSERT INTO "auth_permission" VALUES (47,12,'delete_qualifyingtest','Can delete qualifying test');
INSERT INTO "auth_permission" VALUES (48,12,'view_qualifyingtest','Can view qualifying test');
INSERT INTO "auth_permission" VALUES (49,13,'add_subcourse','Can add sub course');
INSERT INTO "auth_permission" VALUES (50,13,'change_subcourse','Can change sub course');
INSERT INTO "auth_permission" VALUES (51,13,'delete_subcourse','Can delete sub course');
INSERT INTO "auth_permission" VALUES (52,13,'view_subcourse','Can view sub course');
INSERT INTO "auth_permission" VALUES (53,14,'add_topic','Can add topic');
INSERT INTO "auth_permission" VALUES (54,14,'change_topic','Can change topic');
INSERT INTO "auth_permission" VALUES (55,14,'delete_topic','Can delete topic');
INSERT INTO "auth_permission" VALUES (56,14,'view_topic','Can view topic');
INSERT INTO "auth_permission" VALUES (57,15,'add_userprogress','Can add user progress');
INSERT INTO "auth_permission" VALUES (58,15,'change_userprogress','Can change user progress');
INSERT INTO "auth_permission" VALUES (59,15,'delete_userprogress','Can delete user progress');
INSERT INTO "auth_permission" VALUES (60,15,'view_userprogress','Can view user progress');
INSERT INTO "auth_permission" VALUES (61,16,'add_testrequirement','Can add test requirement');
INSERT INTO "auth_permission" VALUES (62,16,'change_testrequirement','Can change test requirement');
INSERT INTO "auth_permission" VALUES (63,16,'delete_testrequirement','Can delete test requirement');
INSERT INTO "auth_permission" VALUES (64,16,'view_testrequirement','Can view test requirement');
INSERT INTO "auth_permission" VALUES (65,17,'add_courseroom','Can add course room');
INSERT INTO "auth_permission" VALUES (66,17,'change_courseroom','Can change course room');
INSERT INTO "auth_permission" VALUES (67,17,'delete_courseroom','Can delete course room');
INSERT INTO "auth_permission" VALUES (68,17,'view_courseroom','Can view course room');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$320000$Y9YLiY3PruxAMT1y3ahdrT$cbX+R2Srq+O6Bl6lVz57bX2jzk2gp+W2Onky1DYtqqw=','2024-08-01 01:18:22.888018',1,'admin','','',1,1,'2024-08-01 01:17:47.499695','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$320000$S9TGoFZXd4YJEPQ96278Q1$01vpV4WOTwaFS1cBmcuX+e9dR3fMCT4ZRC2LfMft/xg=',NULL,0,'rohan','','',0,1,'2024-08-01 01:35:25.535333','');
INSERT INTO "frontend_assessment" VALUES (1,'Maths 1 to Maths 2','maths-1-to-maths-2','Lets check your Maths 1 foundations');
INSERT INTO "frontend_assignment" VALUES (1,'Maths 1 Assigment 1','maths-1-assigment-1','To move to the next topic lets first test you on the basis of this assignment.');
INSERT INTO "frontend_institute" VALUES (1,'IIT Madras','iitm','A prestigious public technical university in Chennai, India, consistently ranked as the best engineering institute in India','institute_logos/IIT_Madras_Logo.svg.png');
INSERT INTO "frontend_institute" VALUES (2,'IIT Delhi','iitd','A public institute of technology in Delhi, India, part of the Indian Institutes of Technology (IITs) known for excellence in technical education and research.','institute_logos/Indian_Institute_of_Technology_Delhi_Logo.svg.png');
INSERT INTO "frontend_institute" VALUES (3,'Harvard','harvard','Harvard University: The oldest institution of higher learning in the United States, renowned for high academic standards, selectivity in admissions, and social prestige.','institute_logos/Harvard_University_coat_of_arms.svg.png');
INSERT INTO "frontend_institute" VALUES (4,'Panjab University','pu','Panjab University (PU), one of the oldest universities in India, has a rich tradition of excellence in teaching and research.','institute_logos/panajb_uni.jpg');
INSERT INTO "frontend_qualifyingtest" VALUES (1,'Data Science Qualifier Test','data-science-qualifier-test','Check your basic knowledge');
INSERT INTO "frontend_qualifyingtest" VALUES (2,'Electronics Qualifier','electronics-qualifier','Lets check your basic knowledge');
INSERT INTO "frontend_qualifyingtest" VALUES (3,'Data Science Advanced Qualifier','data-science-advanced-qualifier','Lets check your data science fundamentals');
INSERT INTO "frontend_subcourse" VALUES (1,'Mathematics 1','mathematics-1','Students learn foundational concepts such as functions (including straight lines, polynomials, exponentials, and logarithms) and discrete mathematics (covering basics and graphs).',0,1,NULL);
INSERT INTO "frontend_subcourse" VALUES (2,'Statistics 1','statistics-1','Statistics I covers fundamental concepts relevant to data science. Topics include probability, hypothesis testing, regression analysis, and basic statistical methods essential for analyzing and interpreting data in the context of data science applications.',0,1,NULL);
INSERT INTO "frontend_subcourse" VALUES (3,'Mathematics 2','mathematics-2','Linear Algebra
Calculus
Probability and Statistics
Optimization
Mathematical Modeling',1,1,1);
INSERT INTO "frontend_topic" VALUES (1,'Natural Numbers and Their Operations','natural-numbers-and-their-operations','Learning outcomes:
1. Why is mathematics necessary for programming and data science?
2. Obtain a clear overview of the topics that are going to be covered in this course. IIT Madras welcomes you to the world’s first BSc Degree program in Programming and Data Science. This program was designed for students and working professionals from various educational backgrounds and different age groups to give them an opportunity to study from IIT Madras without having to write the JEE.  Through our online programs, we help our learners to get access to a world-class curriculum in Data Science and Programming.','https://www.youtube.com/watch?v=F9BZ5JsnjYM&list=PLZ2ps__7DhBZYDZo9A0pZ_i0xhstrk5cR',0,NULL,1);
INSERT INTO "frontend_topic" VALUES (2,'Rational Numbers','rational-numbers','Course Purpose: This is the first of two foundational courses on Mathematics for Data Science, essential for understanding data science concepts that combine mathematics, statistics, and computing.

Basic Concepts: The course begins with basic topics such as numbers, sets, relations, and functions to ensure everyone has a common understanding of terminology and notation.

Coordinate Geometry and Equations: The course covers coordinate geometry, including drawing lines, calculating slopes, and angles, followed by quadratic equations and polynomials.

Advanced Functions: It includes studying exponential and logarithmic functions, which grow at different rates and are important for data science.

Graph Theory: The course introduces graph theory, focusing on nodes and edges to represent networks and relationships, applicable in various real-world contexts like road networks and organizational structures.','https://www.youtube.com/watch?v=F9BZ5JsnjYM&list=PLZ2ps__7DhBbWJi0MKTOAj1ExFoSRrKuV',1,1,1);
INSERT INTO "frontend_course_institutes" VALUES (1,1,1);
INSERT INTO "frontend_course_institutes" VALUES (2,1,2);
INSERT INTO "frontend_course_institutes" VALUES (3,1,3);
INSERT INTO "frontend_course_institutes" VALUES (4,2,1);
INSERT INTO "frontend_course_institutes" VALUES (5,2,3);
INSERT INTO "frontend_course_institutes" VALUES (6,3,3);
INSERT INTO "frontend_course" VALUES (1,'Data Science and Its Applications(Foundation)','data-science-and-its-applicationsfoundation','Intro to Data Science',1);
INSERT INTO "frontend_course" VALUES (2,'Electronic Systems','electronic-systems','Intro to Electronic Systems',2);
INSERT INTO "frontend_course" VALUES (3,'Data Science for Business','data-science-for-business','Data Science Advanced Program',3);
INSERT INTO "django_session" VALUES ('nxe78om34vxryqry75883gfua1iefsa0','.eJxVjMsOwiAURP-FtSG8Hy7d9xsIXC5SNZCUdmX8d9ukC13OnDPzJiFuaw3bwCXMmVwJJ5ffLkV4YjtAfsR27xR6W5c50UOhJx106hlft9P9O6hx1H1tsThmTILIkgMU3iuOaFFwlcB4zYUTGrUqESXYovfgEgJnmSsQUpLPF-7KOAE:1sZKSU:uPgdJkQFgSMsSjVpw6mFgxooLAoNgbwOIFnFNrYxtuk','2024-08-15 01:18:22.894031');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "frontend_subcourse_course_id_5229a970" ON "frontend_subcourse" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "frontend_subcourse_prerequisite_assessment_id_704aad96" ON "frontend_subcourse" (
	"prerequisite_assessment_id"
);
CREATE INDEX IF NOT EXISTS "frontend_topic_prerequisite_assignment_id_c927a7b3" ON "frontend_topic" (
	"prerequisite_assignment_id"
);
CREATE INDEX IF NOT EXISTS "frontend_topic_subcourse_id_11e20d08" ON "frontend_topic" (
	"subcourse_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_user_id_bfc60c23" ON "frontend_userprogress" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_assessments_completed_userprogress_id_assessment_id_3644d18e_uniq" ON "frontend_userprogress_assessments_completed" (
	"userprogress_id",
	"assessment_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_assessments_completed_userprogress_id_2ba1c0f3" ON "frontend_userprogress_assessments_completed" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_assessments_completed_assessment_id_8d8f82c8" ON "frontend_userprogress_assessments_completed" (
	"assessment_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_assignments_completed_userprogress_id_assignment_id_301cd41d_uniq" ON "frontend_userprogress_assignments_completed" (
	"userprogress_id",
	"assignment_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_assignments_completed_userprogress_id_2d23ca4c" ON "frontend_userprogress_assignments_completed" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_assignments_completed_assignment_id_79056a28" ON "frontend_userprogress_assignments_completed" (
	"assignment_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_courses_userprogress_id_course_id_ca20b29b_uniq" ON "frontend_userprogress_courses" (
	"userprogress_id",
	"course_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_courses_userprogress_id_80e4b809" ON "frontend_userprogress_courses" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_courses_course_id_867efa1d" ON "frontend_userprogress_courses" (
	"course_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_institutes_userprogress_id_institute_id_299919e3_uniq" ON "frontend_userprogress_institutes" (
	"userprogress_id",
	"institute_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_institutes_userprogress_id_ba39c2bb" ON "frontend_userprogress_institutes" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_institutes_institute_id_b7b99744" ON "frontend_userprogress_institutes" (
	"institute_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_qualifying_tests_completed_userprogress_id_qualifyingtest_id_75b7953d_uniq" ON "frontend_userprogress_qualifying_tests_completed" (
	"userprogress_id",
	"qualifyingtest_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_qualifying_tests_completed_userprogress_id_1d12e46f" ON "frontend_userprogress_qualifying_tests_completed" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_qualifying_tests_completed_qualifyingtest_id_b3b4172b" ON "frontend_userprogress_qualifying_tests_completed" (
	"qualifyingtest_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_subcourses_userprogress_id_subcourse_id_62295b70_uniq" ON "frontend_userprogress_subcourses" (
	"userprogress_id",
	"subcourse_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_subcourses_userprogress_id_dc70b072" ON "frontend_userprogress_subcourses" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_subcourses_subcourse_id_ca61453a" ON "frontend_userprogress_subcourses" (
	"subcourse_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_userprogress_topics_userprogress_id_topic_id_d3595439_uniq" ON "frontend_userprogress_topics" (
	"userprogress_id",
	"topic_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_topics_userprogress_id_55aa2498" ON "frontend_userprogress_topics" (
	"userprogress_id"
);
CREATE INDEX IF NOT EXISTS "frontend_userprogress_topics_topic_id_9634b37c" ON "frontend_userprogress_topics" (
	"topic_id"
);
CREATE INDEX IF NOT EXISTS "frontend_testrequirement_from_course_id_54d64ff8" ON "frontend_testrequirement" (
	"from_course_id"
);
CREATE INDEX IF NOT EXISTS "frontend_testrequirement_to_course_id_002e956c" ON "frontend_testrequirement" (
	"to_course_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_courseroom_members_courseroom_id_customuser_id_6ea41c5b_uniq" ON "frontend_courseroom_members" (
	"courseroom_id",
	"customuser_id"
);
CREATE INDEX IF NOT EXISTS "frontend_courseroom_members_courseroom_id_1ddf8383" ON "frontend_courseroom_members" (
	"courseroom_id"
);
CREATE INDEX IF NOT EXISTS "frontend_courseroom_members_customuser_id_ecbd8170" ON "frontend_courseroom_members" (
	"customuser_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_course_institutes_course_id_institute_id_a2205be5_uniq" ON "frontend_course_institutes" (
	"course_id",
	"institute_id"
);
CREATE INDEX IF NOT EXISTS "frontend_course_institutes_course_id_8c967172" ON "frontend_course_institutes" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "frontend_course_institutes_institute_id_8e6cbeed" ON "frontend_course_institutes" (
	"institute_id"
);
CREATE INDEX IF NOT EXISTS "frontend_course_qualifying_test_id_c47cc837" ON "frontend_course" (
	"qualifying_test_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
