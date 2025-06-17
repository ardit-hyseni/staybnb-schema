-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP TYPE public."PropertyType";

CREATE TYPE public."PropertyType" AS ENUM (
	'APARTMENT',
	'HOUSE',
	'VILLA',
	'LOFT',
	'CABIN');

-- DROP SEQUENCE public."Amenity_id_seq";

CREATE SEQUENCE public."Amenity_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."Picture_id_seq";

CREATE SEQUENCE public."Picture_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."Property_id_seq";

CREATE SEQUENCE public."Property_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."User_id_seq";

CREATE SEQUENCE public."User_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public."Amenity" definition

-- Drop table

-- DROP TABLE public."Amenity";

CREATE TABLE public."Amenity" (
	id serial4 NOT NULL,
	"name" text NOT NULL,
	description text NULL,
	CONSTRAINT "Amenity_pkey" PRIMARY KEY (id)
);
CREATE UNIQUE INDEX "Amenity_name_key" ON public."Amenity" USING btree (name);


-- public."User" definition

-- Drop table

-- DROP TABLE public."User";

CREATE TABLE public."User" (
	id serial4 NOT NULL,
	"globalId" text NOT NULL,
	email text NOT NULL,
	"name" text NULL,
	"createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updatedAt" timestamp(3) NOT NULL,
	CONSTRAINT "User_pkey" PRIMARY KEY (id)
);
CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);
CREATE UNIQUE INDEX "User_globalId_key" ON public."User" USING btree ("globalId");


-- public."_prisma_migrations" definition

-- Drop table

-- DROP TABLE public."_prisma_migrations";

CREATE TABLE public."_prisma_migrations" (
	id varchar(36) NOT NULL,
	checksum varchar(64) NOT NULL,
	finished_at timestamptz NULL,
	migration_name varchar(255) NOT NULL,
	logs text NULL,
	rolled_back_at timestamptz NULL,
	started_at timestamptz NOT NULL DEFAULT now(),
	applied_steps_count int4 NOT NULL DEFAULT 0,
	CONSTRAINT "_prisma_migrations_pkey" PRIMARY KEY (id)
);


-- public."Property" definition

-- Drop table

-- DROP TABLE public."Property";

CREATE TABLE public."Property" (
	id serial4 NOT NULL,
	title text NOT NULL,
	description text NOT NULL,
	"createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updatedAt" timestamp(3) NOT NULL,
	country text NOT NULL,
	city text NOT NULL,
	price numeric(65, 30) NOT NULL,
	"imageSrc" text NOT NULL,
	beds int4 NOT NULL,
	baths int4 NOT NULL,
	guests int4 NOT NULL,
	"propertyType" public."PropertyType" NOT NULL DEFAULT 'HOUSE'::"PropertyType",
	"hostId" int4 NOT NULL,
	"cleaningFee" numeric(65, 30) NULL,
	latitude float8 NULL,
	longitude float8 NULL,
	CONSTRAINT "Property_pkey" PRIMARY KEY (id),
	CONSTRAINT "Property_hostId_fkey" FOREIGN KEY ("hostId") REFERENCES public."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public."PropertyAmenity" definition

-- Drop table

-- DROP TABLE public."PropertyAmenity";

CREATE TABLE public."PropertyAmenity" (
	"propertyId" int4 NOT NULL,
	"amenityId" int4 NOT NULL,
	CONSTRAINT "PropertyAmenity_pkey" PRIMARY KEY ("propertyId", "amenityId"),
	CONSTRAINT "PropertyAmenity_amenityId_fkey" FOREIGN KEY ("amenityId") REFERENCES public."Amenity"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT "PropertyAmenity_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES public."Property"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public."Reservation" definition

-- Drop table

-- DROP TABLE public."Reservation";

CREATE TABLE public."Reservation" (
	id text NOT NULL,
	"checkIn" timestamp(3) NOT NULL,
	"checkOut" timestamp(3) NOT NULL,
	"totalPrice" numeric(65, 30) NOT NULL,
	"createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"guestId" int4 NOT NULL,
	"propertyId" int4 NOT NULL,
	CONSTRAINT "Reservation_pkey" PRIMARY KEY (id),
	CONSTRAINT "Reservation_guestId_fkey" FOREIGN KEY ("guestId") REFERENCES public."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT "Reservation_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES public."Property"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public."Review" definition

-- Drop table

-- DROP TABLE public."Review";

CREATE TABLE public."Review" (
	id text NOT NULL,
	rating int4 NOT NULL,
	"comment" text NULL,
	"createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"reservationId" text NOT NULL,
	"reviewerId" int4 NOT NULL,
	"propertyId" int4 NOT NULL,
	CONSTRAINT "Review_pkey" PRIMARY KEY (id),
	CONSTRAINT "Review_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES public."Property"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT "Review_reservationId_fkey" FOREIGN KEY ("reservationId") REFERENCES public."Reservation"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT "Review_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES public."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE INDEX "Review_propertyId_idx" ON public."Review" USING btree ("propertyId");
CREATE UNIQUE INDEX "Review_reservationId_key" ON public."Review" USING btree ("reservationId");
CREATE INDEX "Review_reviewerId_idx" ON public."Review" USING btree ("reviewerId");


-- public."Picture" definition

-- Drop table

-- DROP TABLE public."Picture";

CREATE TABLE public."Picture" (
	id serial4 NOT NULL,
	url text NOT NULL,
	"propertyId" int4 NOT NULL,
	"createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT "Picture_pkey" PRIMARY KEY (id),
	CONSTRAINT "Picture_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES public."Property"(id) ON DELETE CASCADE ON UPDATE CASCADE
);
