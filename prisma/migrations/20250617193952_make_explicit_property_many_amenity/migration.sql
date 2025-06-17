/*
  Warnings:

  - You are about to drop the `_AmenityToProperty` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_AmenityToProperty" DROP CONSTRAINT "_AmenityToProperty_A_fkey";

-- DropForeignKey
ALTER TABLE "_AmenityToProperty" DROP CONSTRAINT "_AmenityToProperty_B_fkey";

-- AlterTable
ALTER TABLE "Property" ADD COLUMN     "latitude" DOUBLE PRECISION,
ADD COLUMN     "longitude" DOUBLE PRECISION;

-- DropTable
DROP TABLE "_AmenityToProperty";

-- CreateTable
CREATE TABLE "PropertyAmenity" (
    "propertyId" INTEGER NOT NULL,
    "amenityId" INTEGER NOT NULL,

    CONSTRAINT "PropertyAmenity_pkey" PRIMARY KEY ("propertyId","amenityId")
);

-- AddForeignKey
ALTER TABLE "PropertyAmenity" ADD CONSTRAINT "PropertyAmenity_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyAmenity" ADD CONSTRAINT "PropertyAmenity_amenityId_fkey" FOREIGN KEY ("amenityId") REFERENCES "Amenity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
