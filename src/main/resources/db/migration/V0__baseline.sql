CREATE TABLE Brand
(
    Id         INT PRIMARY KEY,
    Name       VARCHAR(120) NOT NULL,
    ActiveFrom DATE,
    ActiveTo   DATE,
    Successor  INT,
    Parent     INT,
    Country    VARCHAR(2),
    Website    VARCHAR(50),
    FOREIGN KEY (Successor) REFERENCES Brand (Id),
    FOREIGN KEY (Parent) REFERENCES Brand (Id)
);

-- --------------------------
-- Purchase related tables --
-- --------------------------
CREATE TABLE PurchaseLog
(
    Id               INT PRIMARY KEY,
    PurchaseLocation INT,
    PurchaseDate     DATE,
    DeliveryDate     DATE,
    Price            DECIMAL(6, 2)
);

-- ---------------------
-- Nib related tables --
-- ---------------------
CREATE TABLE NibTipping
(
    Id          INT PRIMARY KEY,
    Designation VARCHAR(4),
    Name        VARCHAR(30),
    AliasFor    INT,
    FOREIGN KEY (AliasFor) REFERENCES NibTipping (Id)
);

CREATE TABLE NibMaterial
(
    Id     INT PRIMARY KEY,
    Name   VARCHAR(20),
    Carats INT DEFAULT NULL
);

CREATE TABLE Pen
(
    Id            INT PRIMARY KEY,
    Brand         INT,
    Colourway     VARCHAR(120),
    Series        VARCHAR(120),
    Nib           INT,
    BodyMaterial  INT,
    FillingSystem INT,
    Purchase      INT,
    FOREIGN KEY (Brand) REFERENCES Brand (Id),
    FOREIGN KEY (Purchase) REFERENCES PurchaseLog (Id)
);

-- ---------------------
-- Ink related tables --
-- ---------------------
CREATE TABLE ColourFamily
(
    Id   INT PRIMARY KEY,
    Name VARCHAR(70)
);

CREATE TABLE InkSeries
(
    Id   INT PRIMARY KEY,
    Name VARCHAR(200)
);

CREATE TABLE Ink
(
    Id         INT PRIMARY KEY,
    Name       VARCHAR(200),
    Series     INT,
    Brand      INT,

    -- Ink components
    IronGall   BOOLEAN,
    Pigmented  BOOLEAN,

    -- Ink properties
    FastDrying BOOLEAN,
    Permanent  BOOLEAN,
    Scented    BOOLEAN,
    Shading    BOOLEAN,
    Sheen      BOOLEAN,
    Shimmer    BOOLEAN,

    Wetness    INT,
    FOREIGN KEY (Series) REFERENCES InkSeries (Id)
);

CREATE TABLE InkContainer
(
    Id        INT PRIMARY KEY,
    Ink       INT,
    Size      INT,
    Purchase  INT,
    EmptyDate DATE,
    FOREIGN KEY (Ink) REFERENCES Ink (Id),
    FOREIGN KEY (Purchase) REFERENCES PurchaseLog (Id)
);

CREATE TABLE InkLog
(
    Ink       INT  NOT NULL,
    Pen       INT  NOT NULL,
    InkedDate DATE NOT NULL,
    EmptyDate DATE,
    PRIMARY KEY (Ink, Pen),
    FOREIGN KEY (Ink) REFERENCES Ink (Id),
    FOREIGN KEY (Pen) REFERENCES Pen (Id)
);
